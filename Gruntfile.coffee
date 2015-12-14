module.exports = (grunt)->
  # URI for concat & minify
  grunt.uri = './'

  grunt.libSrc = grunt.uri + 'lib/'
  grunt.coreSrc = grunt.libSrc + 'core/'
  grunt.componentsSrc = grunt.libSrc + 'components/'

  grunt.build = grunt.uri + 'build/'
  grunt.core = grunt.build + 'core/'
  grunt.components = grunt.build + 'components/'
  grunt.dist = grunt.build + 'dist/'


  grunt.initConfig
    watch:
      lib:
        files: [grunt.coreSrc+'*.coffee', grunt.componentsSrc+'**/*.[coffee|jade]']
        tasks: ['coreBuild', 'componentsBuild']
      app:
        files: ['./index.coffee']
        tasks: ['appBuild']

    clean:
      core: [grunt.core]
      components: [grunt.components]
      apidoc: ['apidoc']
      test: ['report', 'coverage']
      app: ['index.js']

    coffee:
      core:
        files:
          'build/core/core.js': grunt.coreSrc+'*.coffee'
      components:
        files: [
          {
            expand: true
            cwd: grunt.componentsSrc
            src: ['**/*.coffee']
            dest: grunt.components,
            ext: '.js'
          }
        ]
      app:
        files:
          'index.js': 'index.coffee'

    ngTemplateCache:
      templates:
        files: [
          'build/views.js': grunt.componentsSrc+'**/*.html'
          'build/components/table/table_view.js': grunt.componentsSrc+'table/*.html'
          'build/components/footer/footer_view.js': grunt.componentsSrc+'footer/*.html'
          'build/components/sidebar/sidebar_view.js': grunt.componentsSrc+'sidebar/*.html'
        ]
        options:
          module: 'OODLib'

      footer:
        files: [
          'build/components/footer/footer_view.js': grunt.componentsSrc+'footer/*.html'
        ]
        options:
          module: 'OOD_Footer'

      table:
        files: [
          'build/components/table/table_view.js': grunt.componentsSrc+'table/*.html'
        ]
        options:
          module: 'OOD_Table'

      sidebar:
        files: [
          'build/components/sidebar/sidebar_view.js': grunt.componentsSrc+'sidebar/*.html'
        ]
        options:
          module: 'OOD_Sidebar'

    jade:
      components:
        options:
          pretty: true
        files: [
          {
            cwd: grunt.componentsSrc
            src: '**/*.jade'
            dest: grunt.components
            expand: true
            ext: '.html'
          }
        ]
    copy:
      core:
        expand: true
        cwd: grunt.core
        src: ['*.js']
        dest: grunt.dist

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
      footer:
        src: [
          grunt.components + 'footer/footer.js'
          grunt.components + 'footer/footer_register.js'
          grunt.components + 'footer/footer_view.js'

        ]
        dest:
          grunt.components + 'footer/c_footer.js'

      table:
        src: [
          grunt.components + 'table/table.js'
          grunt.components + 'table/table_register.js'
          grunt.components + 'table/table_translation.js'
          grunt.components + 'table/table_view.js'
        ]
        dest:
          grunt.components + 'table/c_table.js'

      sidebar:
        src: [
          grunt.components + 'sidebar/sidebar.js'
          grunt.components + 'sidebar/sidebar_register.js'
          grunt.components + 'sidebar/sidebar_translation.js'
          grunt.components + 'sidebar/sidebar_view.js'
        ]
        dest:
          grunt.components + 'sidebar/c_sidebar.js'

      dist:
        src: [
          grunt.core + 'core.js'
          grunt.components + 'table/c_table.js'
          grunt.components + 'footer/c_footer.js'
          grunt.components + 'sidebar/c_sidebar.js'
        ]
        dest:
          grunt.dist + 'ood-omega.js'

    uglify:
      core:
        cwd: grunt.core
        dest: grunt.dist
        expand: true
        ext: '.min.js'
        flatten: true
        src: [
          '*.js'
        ]

      dist:
        files:
          'build/dist/ood-omega.min.js': grunt.dist+'ood-omega.js'

    nggettext_extract:
      table:
        files:
          'build/components/table/table.pot': [grunt.components+'/table/table.html']
      sidebar:
        files:
          'build/components/sidebar/sidebar.pot': [grunt.components+'/sidebar/sidebar.html']

    nggettext_compile:
      table:
        files:
          'build/components/table/table_translation.js': [grunt.components+'/table/table.pot']
      sidebar:
        files:
          'build/components/sidebar/sidebar_translation.js': [grunt.components+'/sidebar/sidebar.pot']


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-hustler'
  grunt.loadNpmTasks 'grunt-angular-gettext'

  grunt.registerTask "coreBuild", ["clean:core", "coffee:core", "uglify:core", "copy:core"]

  grunt.registerTask "componentsBuild", ["jade:components", "coffee:components"]

  grunt.registerTask "footerCreator", ["ngTemplateCache:footer", "concat:footer"]

  grunt.registerTask "tablePreCreator", ["ngTemplateCache:table", "nggettext_extract:table"]
  grunt.registerTask "tablePostCreator", ["nggettext_compile:table", "concat:table"]

  grunt.registerTask "sidebarPreCreator", ["ngTemplateCache:sidebar",  "nggettext_extract:sidebar"]
  grunt.registerTask "sidebarPostCreator", ["nggettext_compile:sidebar", "concat:sidebar"]

  grunt.registerTask "package", ["concat:dist", "uglify:dist"]

  grunt.registerTask "appBuild", ["clean:app", "coffee:app"]

  grunt.registerTask "test", ["clean:test", "shell:karma"]
  
  grunt.registerTask "apidoc", ["clean:apidoc", "shell:apidoc"]
