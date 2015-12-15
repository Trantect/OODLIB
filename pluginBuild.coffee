_ = require 'underscore'

class BuildProcess
  constructor: (@fName, src, dest) ->
    @src = src ? ('lib/components/' + fName + '/')
    @dest = dest ? ('build/components/' + fName + '/')
    @tmpBuild = @src+'.build/'
  ###
  Compile template
  ###
  compileTemplate: () ->
    config =
      files: [
        {
          cwd: @src
          src: '*.jade'
          dest: @src
          expand: true
          ext: '.html'
        }
      ]

  ###
  Compile Logic 
  ###
  compileLogic: () ->
    config =
      files: [
        {
          expand: true
          cwd: @src
          src: ['*.coffee']
          dest: @tmpBuild
          ext: '.js'
        }
      ]

  ###
  template caching
  ###
  templateCaching: () ->
    files = []
    files[0] = {}
    viewFile = @tmpBuild + 'view.js'
    files[0][viewFile] = @src+'*.html'
    config =
      files: files
      options:
        module: 'OOD_' + @fName


  ###
  retrieve translation material
  ###
  extractTranslation: () ->
    files = {}
    potFile = @tmpBuild + 'translate.pot'
    files[potFile] = [@src+'*.html']
    config =
      files: files


  ###
  compile translation .pot into .js
  ###
  compileTranslation: () ->
    files = {}
    jsFile = @tmpBuild + 'translate.js'
    files[jsFile] = [@tmpBuild+'translate.pot']
    config =
      files: files


  ###
  concat logic code, template cache, translation, register into one
  ###
  concatIntoComponent: () ->

    config =
      src: [
        @tmpBuild + 'X_*.js'
        @tmpBuild + 'register.js'
        @tmpBuild + 'translate.js'
        @tmpBuild + 'view.js'
      ]
      dest:
        @dest + 'c_' + @fName + '.js'

  clean: () ->
    config = [@tmpBuild, @dest, @src+'*.html']

  generateConfig: () ->
    raw =
      clean: @clean
      coffee: @compileLogic
      jade: @compileTemplate
      ngTemplateCache: @templateCaching
      nggettext_extract: @extractTranslation
      nggettext_compile: @compileTranslation
      concat: @concatIntoComponent
    config = _.mapObject raw, (v, k) =>
      tmp = {}
      tmp[@fName] = v.apply @
      tmp

  generatePreTask: () ->
    taskName = @fName + 'PreCreator'
    _seq = ["coffee", "jade", "ngTemplateCache", "nggettext_extract"]
    seq = _.map _seq, (v) =>
      v + ":" + @fName
    [taskName, seq]

  generatePostTask: () ->
    taskName = @fName + 'PostCreator'
    _seq = ["nggettext_compile", "concat"]
    seq = _.map _seq, (v) =>
      v + ":" + @fName
    [taskName, seq]


module.exports = BuildProcess
