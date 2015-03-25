React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

App           = require 'components/App'
Map           = require 'components/Map'
AddressesList = require 'components/AddressesList'

describe 'App test', ->
  beforeEach ->
    @addresses = [
      address: 'Test address'
      latitude: 23
      longitude: 2
    ]

    @component = TestUtils.renderIntoDocument <App addresses={ @addresses } />

  it 'set filtered addresses to empty array by default', ->
    expect( @component.state.filteredAddresses ).toEqual []

  describe 'and filtered addresses changed', ->
    beforeEach ->
      @newAddresses = [
        address: 'Test address'
      ]

      @component.setState filteredAddresses: @newAddresses

    it 'renders google map with filtered addresses', ->
      @map = TestUtils.findRenderedComponentWithType @component, Map

      expect( @map.props.addresses ).toBe @newAddresses

    it 'renders addresses list with passed addresses', ->
      @list = TestUtils.findRenderedComponentWithType @component, AddressesList

      expect( @list.props.addresses ).toBe @newAddresses
