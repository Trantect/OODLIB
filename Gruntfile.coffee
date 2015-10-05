module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['lib/**/*.coffee', 'lib/**/*.jade', './index.coffee']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 550

    clean:
      dev: ['build', './index.js']

    coffee:
      lib:
        files: [
          {
            expand: true,
            cwd: 'lib'
            src: ['**/*.coffee'],
            dest: './build',
            ext: '.js'
          }
        ]
      app:
        files:
          'index.js': 'index.coffee'
    jade:
      dev:
        options:
          pretty: true
        files:
          "lib/table/table.html": ["lib/table/table.jade"]
  
    copy:
      dev:
        expand: true
        cwd: 'lib/'
        src: ['**/*','!**/*.coffee']
        dest:'build/'

    mochaTest:
      dev:
        options:
          reporter: 'spec',
          require: 'coffee-script/register'
        src: ['test/**/*.coffee']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask "default", ["clean:dev", "jade:dev", "coffee:lib", "coffee:app", "copy:dev"]
  grunt.registerTask "cleanBuild", ["clean:dev"]

  
