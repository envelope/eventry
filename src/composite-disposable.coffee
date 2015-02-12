module.exports =
class CompositeDisposable
  disposed: false

  constructor: (disposables...) ->
    @disposables = []
    @add disposable for disposable in disposables

  dispose: ->
    unless @disposed
      @disposed = true

      for disposable in @disposables
        disposable.dispose()

      @disposables = []

  add: (disposable) ->
    @disposables.push(disposable) unless @disposed

  remove: (disposable) ->
    index = @disposables.indexOf disposable
    @disposables.splice(index, 1) if index isnt -1

  clear: ->
    @disposables = []
