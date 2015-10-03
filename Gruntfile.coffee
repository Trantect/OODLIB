module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['lib/**/*.coffee']
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

    copy:
      dev:
        expand:true
        cwd:'lib/'
        src:['**/*','!**/*.coffee']
        dest:'build/'


  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask "default", ["clean:dev","coffee:dev","copy:dev"]
  grunt.registerTask "cleanBuild", ["clean:dev"]

  
