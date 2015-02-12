Disposable = require './disposable'

module.exports =
class Emitter
  disposed: false

  constructor: ->
    @handlersByEventName = {}

  on: (eventName, handler) ->
    if @disposed
      throw new Error "Emitter is disposed"

    if typeof handler isnt 'function'
      throw new Error "Event handler must be a function"

    if currentHandlers = @handlersByEventName[eventName]
      currentHandlers.push handler
    else
      @handlersByEventName[eventName] = [handler]

    new Disposable @off.bind(this, eventName, handler)

  off: (eventName, handlerToRemove) ->
    return if @disposed

    if handlers = @handlersByEventName[eventName]
      index = handlers.indexOf handlerToRemove
      handlers.splice index, 1 if ~index

      # Clean up
      delete @handlersByEventName[eventName] if handlers.length is 0

  emit: (eventName, value) ->
    if handlers = @handlersByEventName?[eventName]
      handler value for handler in handlers

    return

  dispose: ->
    @handlersByEventName = null
    @disposed = true
