describe 'Create Footer model without data', () ->
  f = undefined

  beforeEach () ->
    f = new Footer()

  it 'init footer', (done) ->
    (expect f).toBeDefined()
    (expect f.data).toEqual undefined
    done()

describe 'Create Footer model with data', () ->
  f = data = undefined
  beforeEach () ->
    data =
      name: "Demo"
      status: "alpha"
      version: "0.0.1"
      website: "http://www.trantect.com/"
      websiteName: "our site"
      year: "2015"

    f = new Footer data

  it 'init footer', (done) ->
    (expect f.data).toEqual data
    done()
