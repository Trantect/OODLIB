_ = require 'underscore'
pb = require './pluginBuild'

ddmHeader = new pb 'dropdownMenu'
footer = new pb 'footer'
sidebar = new pb 'sidebar'
table = new pb 'table'
topBar = new pb 'topBar'

components = [ddmHeader, footer, sidebar, table, topBar]
componentConfig = _.map components, (v) ->
  v.generateConfig()

libSrc = 'lib/'
coreSrc = libSrc + 'core/'
componentsSrc = libSrc + 'components/'

build = 'build/'
coreBuild = build + 'core/'
componentsBuild = build + 'components/'

dist = build + 'dist/'


tasks =
  watch:
    lib:
      files: [coreSrc+'*.coffee', componentsSrc+'**/*.[coffee|jade]']
      tasks: ['coreBuild', 'componentsBuild']
    app:
      files: ['./index.coffee']
      tasks: ['appBuild']

  clean:
    core: [coreBuild]
    dist: [dist]
    apidoc: ['apidoc']
    test: ['report', 'coverage']
    app: ['index.js']

  coffee:
    core:
      files:
        'build/core/core.js': coreSrc+'*.coffee'
    app:
      files:
        'index.js': 'index.coffee'

  ngTemplateCache: {}

  jade: {}

  mochaTest:
    dev:
      options:
        reporter: 'spec',
        require: 'coffee-script/register'
      src: ['test/**/*.coffee']

  shell:
    apidoc:
      command: './node_modules/.bin/codo'
    karma:
      command: './karmarun.sh'
    coverage:
      command: 'python karmaReport.py'

  concat:
    core:
      src: [
        libSrc + 'version.js'
        coreBuild + 'core.js'
      ]
      dest:
        coreBuild + 'core.js'
    dist:
      src: [
        libSrc + 'version.js'
        coreBuild + 'core.js'
        componentsBuild + '**/c_*.js'
      ]
      dest:
        dist + 'ood-omega.js'

  uglify:
    core:
      files:
        'build/core/core.min.js': coreBuild+'core.js'
      options:
        preserveComments: true
    dist:
      files:
        'build/dist/ood-omega.min.js': dist+'ood-omega.js'
      options:
        preserveComments: true

  nggettext_extract: {}
  nggettext_compile: {}

_.each componentConfig, (_config) ->
  _.each _config, (v, k) ->
    _.extend tasks[k], v
  
module.exports = (grunt)->

  grunt.initConfig tasks

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-hustler'
  grunt.loadNpmTasks 'grunt-angular-gettext'

  grunt.registerTask "coreBuild", ["clean:core", "coffee:core", "concat:core", "uglify:core"]
  grunt.registerTask "package", ["concat:dist", "uglify:dist"]
  grunt.registerTask "appBuild", ["clean:app", "coffee:app"]
  grunt.registerTask "test", ["clean:test", "shell:karma"]
  grunt.registerTask "apidoc", ["clean:apidoc", "shell:apidoc"]

  componentsTask = []
  _.each components, (v) ->
    [taskName, seq] = v.generatePreTask()
    grunt.registerTask taskName, seq
    componentsTask.push taskName

    [taskName, seq] = v.generatePostTask()
    grunt.registerTask taskName, seq
    componentsTask.push taskName

  grunt.registerTask 'componentsBuild', componentsTask
  grunt.registerTask 'default', ['coreBuild', 'componentsBuild', 'package', 'appBuild']
