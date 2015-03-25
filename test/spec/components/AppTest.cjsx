React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

App           = require 'components/App'
Map           = require 'components/Map'
AddressesList = require 'components/AddressesList'
addresses     = require 'src/addresses'

describe 'App test', ->
  beforeEach ->
    @component = TestUtils.renderIntoDocument <App />

  it 'renders google map with addresses', ->
    @map = TestUtils.findRenderedComponentWithType @component, Map

    expect( @map.props.addresses ).toBe addresses

  it 'renders addresses list with passed addresses', ->
    @list = TestUtils.findRenderedComponentWithType @component, AddressesList

    expect( @list.props.addresses ).toBe addresses
