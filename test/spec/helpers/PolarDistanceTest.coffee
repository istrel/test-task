PolarDistance = require 'helpers/PolarDistance'

describe 'PolarDistance', ->
  it 'produces correct value', ->
    # a regression test
    result = PolarDistance([89, 20], [-89, -20])
    testValue = 19806109.93318094

    expect( Math.abs( result - testValue ) ).toBeLessThan 0.001

