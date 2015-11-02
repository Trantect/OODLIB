
describe "UI Test", () ->
  it "Create UI instance without arguments", (done) ->
    ui = new UI
    (expect ui).toBeDefined()
    (expect ui.config).toEqual {}
    (expect ui.handlers).toEqual {}
    (expect () ->
      ui.setHandler 'print', () ->
    ).toThrowError 'No events has defined for your handler'
    done()

  it "Create UI instance with correct arguments", (done) ->
    config = [
      selector: 'tr'
      action: 'click'
      handlerName: 'displayDetails'
    ,
      selector: 'tr'
      action: 'mouseover'
      handlerName: 'displayOptionButtons'
    ]


    ui = new UI config

    (expect ui).toBeDefined()
    (expect ui.config).toEqual config
    (expect ui.handlers.displayDetails).toBeDefined()
    (expect ui.handlers.displayOptionButtons).toBeDefined()

    (expect () ->
      ui.setHandler 'print', () ->
    ).toThrowError 'No events has defined for your handler'

    fn = () ->
      console.log "hello"

    ui.setHandler 'displayDetails', fn
    (expect ui.handlers.displayDetails).toEqual fn
    done()
     

   



