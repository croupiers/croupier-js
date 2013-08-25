'use strict'

exports.generator =
  gen: (fn) ->
    nxt = ->
      @value= fn()
      @done= no
      {value: @value, done: @done}
    {value: fn(), done: no, next: nxt}
