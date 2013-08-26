'use strict'

class Generator
  constructor: (@fn, @done, @value=@fn()) ->

  next: ->
    @value = @fn()
    @done = no
    {value: @value, done: @done}

  map: (fn) ->
    parentFn = @fn
    new Generator (-> fn(parentFn())), no


exports.generator =
  gen: (fn,done=no) ->
    new Generator(fn, done)
