# Karma configuration
# Generated on Wed Oct 28 2015 17:28:48 GMT+0800 (CST)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '../../'


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine']


    # list of files / patterns to load in the browser
    files: [
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'bower_components/underscore/underscore-min.js',
      'lib/common/base.coffee',
      'test/common/model.test.coffee',
      'test/common/css.test.coffee',
      'test/common/directive.test.coffee',
      'test/common/directiveSchool.test.coffee'
    ]


    # list of files to exclude
    exclude: [
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      '**/common/*.coffee': ['coffee']
      'lib/common/base.coffee': ['coverage']
    }

    plugins: [
      'karma-jasmine',
      'karma-chrome-launcher',
      'karma-coffee-preprocessor',
      'karma-coverage'
    ]

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress', 'coverage']


    coverageReporter:
      reporters: [
        type: 'json',
        dir: 'report/coverage/',
        subdir: (browser) ->
          browser.toLowerCase().split(/[ /-]/)[0]
        ,
        file: 'coverage-common-base.json'
      ,
        type: 'text-summary'
      ,
        type: 'html'
      ]


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: true
