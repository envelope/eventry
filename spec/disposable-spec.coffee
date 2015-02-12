describe "Disposable", ->
  Disposable = require '../src/disposable'

  describe ".dispose()", ->
    disposable = null
    called = null
    count = null

    beforeEach ->
      called = false
      count = 0
      disposable = new Disposable -> called = true; count++
      disposable.dispose()

    it "sets the `disposed` variable to true", ->
      expect(disposable.disposed).toBe true

    it "invokes the disposalCallback function", ->
      expect(called).toBe true

    it "doesn't invoke the disposalCallback function more than once", ->
      disposable.dispose()
      disposable.dispose()
      expect(count).toBe 1
