module.exports =
class Disposable
  disposed: false

  constructor: (@disposalCallback) ->

  dispose: ->
    unless @disposed
      @disposed = true
      @disposalCallback?()
      @disposalCallback = null
      @dispose = ->
