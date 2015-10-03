module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['OODLib/*.coffee']
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
            cwd: 'OODLib',
            src: ['*.coffee'],
            dest: './build',
            ext: '.js'
          }
        ]

  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask "default", ["clean:dev","coffee:dev"]
  grunt.registerTask "cleanBuild", ["clean:dev"]

  
