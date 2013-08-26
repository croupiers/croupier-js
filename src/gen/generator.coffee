'use strict'

class Generator
  # Done is still just constantly false
  constructor: (@fn, @done=no, @value) ->

  next: ->
    @value = @fn()
    @done = no
    {value: @value, done: @done}

  map: (fn) ->
    parentFn = @fn
    new Generator -> fn(parentFn())

  filter: (fn) ->
    parentGen = @
    new Generator ->
      result = parentGen.next().value
      result = parentGen.next().value while not fn(result)
      result


exports.generator =
  gen: (fn,done=no) ->
    new Generator(fn, done)
