base = require '../../lib/common/base'
chai = require 'chai'
GLOBAL._ = require 'underscore'


chai.should()
expect = chai.expect

describe 'base lib test', () ->

  describe 'EventRegister test', () ->

    it 'register to be a function', (done) ->
      event = base.EventRegister
      expect(event.register).to.be.a('function')
      done()

    it 'register events on element',(done) ->

      eventReg = base.EventRegister
      events =
        click:()->
          console.log 'event click'
        move:()->
          console.log 'event move'

      button = {}
      button.on = (key,value)->
        button[key] = value

      eventReg.register(button,events)
      expect(button.click).to.be.a('function')
      expect(button.move).to.be.a('function')
      done()

  describe 'Directive test', () ->

    it 'register to be a function', (done) ->
      directiveReg = base.Directive
      expect(directiveReg.register).to.be.a('function')
      done()

    it 'register Directive',(done) ->
      directiveReg = base.Directive
      app = {}
      name = 'tabDirective'
      config = {}

      app.directive = (name,attr)->
        @name = name
        attr()

      directiveReg.register(app,name,config)
      expect(app.name).to.equal(name)
      done()