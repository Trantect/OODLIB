# Karma configuration

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
      # 'bower_components/jquery/dist/jquery.min.js',
      'lib/common/base.coffee',
      'lib/footer/footer.coffee',
      'lib/footer/footer.html',
      'test/footer/model.test.coffee',
      'test/footer/css.test.coffee',
      'test/footer/directive.test.coffee',
      'test/footer/angular.test.coffee'
    ]


    # list of files to exclude
    exclude: [
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'lib/**/*.html': ['ng-html2js']
      '**/**/*.coffee': ['coffee']
      'lib/footer/footer.coffee': ['coverage']
    }

    plugins: [
      'karma-jasmine',
      'karma-chrome-launcher',
      'karma-coffee-preprocessor',
      'karma-coverage',
      'karma-ng-html2js-preprocessor'
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
        file: 'coverage-footer.json'
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
