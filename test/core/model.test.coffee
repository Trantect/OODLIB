describe 'Model Test', () ->
  it 'Create model instance with nothing', (done) ->
    M_Undefined = new Model
    (expect M_Undefined.data).toBeUndefined()
    done()

  it 'Create model instance with number', (done) ->
    M_Number = new Model 1
    (expect M_Number.data).toBe 1
    done()

  it 'Create model instance with string', (done) ->
    M_String = new Model "Hello world"
    (expect M_String.data).toBe "Hello world"
    done()

  it 'Create model instance with object', (done) ->
    obj =
      name: 'juice'
      age: 12
    M_Obj = new Model obj
    (expect M_Obj.data).toBe obj
    done()


