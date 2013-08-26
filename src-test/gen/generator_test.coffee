'use strict'

gen = require('../lib/generator.js').generator

#  ======== A Handy Little Nodeunit Reference ========
#  https://github.com/caolan/nodeunit
#
#  Test methods:
#    test.expect(numAssertions)
#    test.done()
#  Test assertions:
#    test.ok(value, [message])
#    test.equal(actual, expected, [message])
#    test.notEqual(actual, expected, [message])
#    test.deepEqual(actual, expected, [message])
#    test.notDeepEqual(actual, expected, [message])
#    test.strictEqual(actual, expected, [message])
#    test.notStrictEqual(actual, expected, [message])
#    test.throws(block, [error], [message])
#    test.doesNotThrow(block, [error], [message])
#    test.ifError(value)

exports['generator'] =
  setUp: (done) ->
    @constantGenerator = gen.gen(-> 1)
    done()

  'responds to map': (test) ->
    test.equal(typeof @constantGenerator.map, "function", "responds to map")
    test.done()

  'map acts like a map higher order function': (test) ->
    map = @constantGenerator.map((x) -> 2 * x)
    a = map.next()
    test.equal(a.value, 2, "maps values to fn(values)")
    b = map.next()
    test.equal(b.value, 2, "maps values to fn(values)")
    test.done()

  'returns an object': (test) ->
    first = @constantGenerator.next()
    test.equal(first.value, 1, "expected next.value to be one")
    test.ok(not first.done, "expected next not to be done")
    test.done()

  'returns an independent object': (test) ->
    first = @constantGenerator.next()
    second = @constantGenerator.next()
    first.value += 23
    second.value = not first.value
    test.ok first.value isnt second.value, "first and second objects are independent"
    test.ok @constantGenerator.value isnt second.value, "generator and second objects are independent"
    test.ok @constantGenerator.value isnt first.value, "generator and first objects are independent"
    test.done()
