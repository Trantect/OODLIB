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