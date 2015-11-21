describe "angular OODLib Test", () ->
  it "OOD is exposed", (done) ->
    (expect OOD).toBeDefined()
    (expect OOD.name).toEqual 'OODLib'
    (expect OOD.requires).toEqual ['gettext']
    done()
