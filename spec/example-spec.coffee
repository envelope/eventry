Emitter = require '../src/emitter'
Composite = require '../src/composite-disposable'

describe "Example", ->
  User = null
  UserView = null

  beforeEach ->
    class User
      constructor: ({@name, @age} = properties) ->
        @emitter = new Emitter

      onDidChangeName: (callback) ->
        @emitter.on 'did-change-name', callback

      onDidChangeAge: (callback) ->
        @emitter.on 'did-change-age', callback

      setName: (name) ->
        if name isnt @name
          @emitter.emit 'did-change-name', @name = name

      setAge: (age) ->
        if age isnt @age
          @emitter.emit 'did-change-age', @age = age

    class UserView
      constructor: (@user) ->
        @name = @user.name
        @age = @user.age
        @subscriptions = new Composite

        @subscriptions.add @user.onDidChangeName (name) => @name = name
        @subscriptions.add @user.onDidChangeAge (age) => @age = age

      destroy: ->
        @subscriptions.dispose()

  it "can subscribe to events", ->
    user = new User name: "foo", age: 20
    view = new UserView user

    expect(view.name).toBe "foo"
    expect(view.age).toBe 20

    user.setName "bar"
    user.setAge 30

    expect(view.name).toBe "bar"
    expect(view.age).toBe 30

