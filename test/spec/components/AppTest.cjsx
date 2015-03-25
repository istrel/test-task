React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

App           = require 'components/App'
Map           = require 'components/Map'
AddressesList = require 'components/AddressesList'
points        = require 'src/points'

describe 'App test', ->
  beforeEach ->
    @component = TestUtils.renderIntoDocument <App />

  it 'renders google map', ->
    TestUtils.findRenderedComponentWithType @component, Map

  it 'renders addresses list with points', ->
    @list = TestUtils.findRenderedComponentWithType @component, AddressesList

    expect( @list.props.addresses ).toBe points