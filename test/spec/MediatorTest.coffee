Mediator = require 'src/scripts/Mediator'
EventEmitter = require('events').EventEmitter

describe 'Mediator', ->
  it 'is an event emitter', ->
    expect(Mediator instanceof EventEmitter).toBe true
