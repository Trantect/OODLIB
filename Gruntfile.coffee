module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['lib/**/*.coffee', 'lib/**/*.jade']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 550

    clean:
      dev: ['build']

    coffee:
      dev:
        files: [
          {
            expand: true,
            cwd: 'lib',
            src: ['**/*.coffee'],
            dest: './build',
            ext: '.js'
          }
        ]

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


  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask "default", ["clean:dev", "jade:dev", "coffee:dev","copy:dev"]
  grunt.registerTask "cleanBuild", ["clean:dev"]

  
