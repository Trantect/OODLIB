module.exports = (grunt)->
  grunt.initConfig

    watch:
      lib:
        files: ['lib/**/*.coffee', 'lib/**/*.jade']
        tasks: ['libBuild']
      app:
        files: ['./index.coffee']
        tasks: ['appBuild']
    clean:
      lib: ['build', 'libdocs']
      app: ['index.js']

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
      lib:
        options:
          pretty: true
        files:
          "lib/table/table.html": ["lib/table/table.jade"]
  
    copy:
      lib:
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

    docco:
      lib:
        src: ['lib/**/*.coffee'],
        options:
          output: 'libdocs/'
 
  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-docco'


  grunt.registerTask "libBuild", ["clean:lib", "jade:lib", "coffee:lib", "copy:lib", 'docco:lib']
  grunt.registerTask "appBuild", ["clean:app", "coffee:app"]
  grunt.registerTask "default", ['libBuild', 'appBuild']
  grunt.registerTask "cleanBuild", ["clean:dev"]
  grunt.registerTask "test", ["mochaTest:dev"]

  
