Emitter = require '../src/emitter'
Disposable = require '../src/disposable'

describe "Emitter", ->
  emitter = null

  beforeEach -> emitter = new Emitter

  describe ".on(eventName, handler)", ->
    it "throws an error if the handler isn't a function", ->
      expect(-> emitter.on 'foo', null).toThrow()

    it "throws an error if the emitter is disposed", ->
      emitter.dispose()
      handler = ->
      expect(-> emitter.on 'foo', handler).toThrow()

    it "returns a disposable object", ->
      disposable = emitter.on 'foo', ->
      expect(disposable instanceof Disposable).toBe true

  describe ".off(eventName, handlerToRemove)", ->
    emitter = null

    beforeEach ->
      emitter = new Emitter

    it "removes the handler from the event's handlers array", ->
      handler1 = -> 'foo'
      handler2 = -> 'bar'
      emitter.on 'foo', handler1
      emitter.on 'foo', handler2

      expect(emitter.handlersByEventName.foo.length).toBe 2
      emitter.off 'foo', handler1
      expect(emitter.handlersByEventName.foo.length).toBe 1

  describe ".emit(eventName, value)", ->
    emitter = null
    fooValues = null
    barValues = null
    foo = null
    bar = null

    beforeEach ->
      fooValues = []
      emitter = new Emitter
      foo = emitter.on 'foo', (value) -> fooValues.push value
      bar = emitter.on 'bar', (value) -> barValues.push value

    it "invokes the handler for the named event", ->
      emitter.emit 'foo', 'bar'
      emitter.emit 'foo', 'baz'
      expect(fooValues).toEqual ['bar', 'baz']

    it "removes the handler when the observer is disposed", ->
      emitter.emit 'foo', 'bar'
      foo.dispose()
      emitter.emit 'foo', 'baz'
      expect(fooValues).toEqual ['bar']
