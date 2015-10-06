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
      button.on = (key,selector,value)->
        button[key] = value

      eventReg.register(button,'.class',events)
      expect(button.click).to.be.a('function')
      expect(button.move).to.be.a('function')
      done()

  describe 'DirectiveSchool test', () ->

    it 'register to be a function', (done) ->
      directiveReg = base.DirectiveSchool
      expect(directiveReg.register).to.be.a('function')
      done()

    it 'register DirectiveSchool',(done) ->
      directiveReg = base.DirectiveSchool
      app = {}
      name = 'tabDirective'
      config = {}
      config.params = ()->
        console.log 'params'

      app.directive = (name,attr)->
        @name = name
        attr()

      directiveReg.register(app,name,config)
      expect(app.name).to.equal(name)
      done()

  describe 'Directive test', () ->

    it 'constructor to be a function', (done) ->
      directive = base.Directive
      d1 = new directive()
      expect(directive.constructor).to.be.a('function')
      expect(d1.move).to.be.a('function')
      expect(d1.initHandlers).to.be.a('function')
      expect(d1.params).to.be.a('function')
      done()

    it 'move function test', (done) ->
      directive = base.Directive
      d1 = new directive({opt:'optValue',controller:'Ctl'})
      expect(d1.config.opt).to.equal('optValue')
      expect(d1.config.controller).to.equal('Ctl')
      d1.move('opt','controller')
      expect(d1.config.opt).to.be.an('undefined')
      expect(d1.config.controller).to.be.an('undefined')
      expect(d1.opt).to.equal('optValue')
      expect(d1.controller).to.equal('Ctl')
      done()

    it 'initHandlers function test',(done)->
      eventsObj =
        tr:
          hover: 'trHoverFnc'
          click: 'trClickFnc'
        td:
          hover: 'tdHoverFnc'
          click: 'tdClickFnc'

      directive = base.Directive
      d1 = new directive({events:eventsObj})

      expect(d1.handlers.trHoverFnc).to.be.a('Function')
      expect(d1.handlers.trClickFnc).to.be.a('Function')
      expect(d1.handlers.tdHoverFnc).to.be.a('Function')
      expect(d1.handlers.tdClickFnc).to.be.a('Function')

      done()

    it 'registerEvents functon test',(done)->

      eventsObj =
        tr:
          hover: 'trHoverFnc'
          click: 'trClickFnc'
        td:
          hover: 'tdHoverFnc'
          click: 'tdClickFnc'

      button = {}
      button.on = (key,selector,value)->
        button[key] = value

      directive = base.Directive
      d1 = new directive({events:eventsObj})
      d1.registerEvents(button,eventsObj)
      expect(button.click).to.be.a('function')
      expect(button.hover).to.be.a('function')
      done()

    it 'params function test',(done) ->
      eventsObj =
        tr:
          hover: 'trHoverFnc'
          click: 'trClickFnc'
        td:
          hover: 'tdHoverFnc'
          click: 'tdClickFnc'

      optionsObj =
        trValue:'@'

      directive = base.Directive
      d1 = new directive({events:eventsObj,options:optionsObj})
      expect(d1.config.scope).to.eql({})
      d1.params()
      expect(d1.dParams.link).to.be.a('Function')
      done()