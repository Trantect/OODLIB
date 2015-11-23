describe 'Create Footer model without info', () ->
  f = data = undefined

  beforeEach () ->
    f = new Footer()

    data =
      copyright: "EMPTY copyright"
      version: "EMPTY version"
      websites: []

  it 'init footer', (done) ->
    (expect f).toBeDefined()
    (expect f.rawData).toEqual data
    (expect f.copyright).toEqual data.copyright
    (expect f.version).toEqual data.version
    (expect f.websites).toEqual data.websites
    (expect f.lenOfSites).toEqual 0
    done()

describe 'Create Footer model with info', () ->
  f = data = undefined
  beforeEach () ->
    data =
      copyright: "2015 Demo"
      version: "0.0.1 alpha"
      websites: [
        "trantect": "http://www.trantect.com/"
      ,
        "baidu": "http://www.baidu.com"
      ,
        "trantect": "http://www.trantect.com/"
      ,
        "baidu": "http://www.baidu.com"
      ]

    f = new Footer data

  it 'init footer', (done) ->
    (expect f).toBeDefined()
    (expect f.rawData).toEqual data
    (expect f.copyright).toEqual data.copyright
    (expect f.version).toEqual data.version
    (expect f.websites).toEqual data.websites
    (expect f.lenOfSites).toEqual 4
    done()

  it 'should get first website link', (done) ->
    (expect f.getLink data.websites[0]).toEqual "http://www.trantect.com/"
    done()

  it 'should get first website name', (done) ->
    (expect f.getName data.websites[0]).toEqual "trantect"
    done()
