React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'
_           = require 'underscore'

App           = require 'components/App'
Map           = require 'components/Map'
AddressesList = require 'components/AddressesList'

Mediator      = require 'src/scripts/Mediator'
PolarDistance = require 'helpers/PolarDistance'

describe 'App test', ->
  beforeEach ->
    @addresses = [
      address: 'Test address'
      latitude: 23
      longitude: 2
    ,
      address: 'Too long point'
      latitude: 73
      longitude: 2.3
    ,
      address: 'Too long point'
      latitude: 73
      longitude: 2.2
    ]

    @component = TestUtils.renderIntoDocument <App addresses={ @addresses } />

  it 'set filtered addresses to empty array by default', ->
    expect( @component.state.filteredAddresses ).toEqual []

  describe 'and new position set', ->
    beforeEach ->
      # set position between last two points
      Mediator.emit 'setPosition',
        latitude: 73
        longitude: 2.25

    it 'set state with new addresses', ->
      expect( @component.state.filteredAddresses ).toEqual(
        _(@addresses)
          .chain()
          .map( (a, id) ->
            distance = PolarDistance [73, 2.25], [a.latitude, a.longitude]
            _.extend { id, distance }, a
          )
          .rest()
          .value()
      )

  describe 'and filtered addresses changed', ->
    beforeEach ->
      @newAddresses = [
        address: 'Test address'
        id: 6
      ]

      @component.setState filteredAddresses: @newAddresses

    it 'renders google map with filtered addresses', ->
      @map = TestUtils.findRenderedComponentWithType @component, Map

      expect( @map.props.addresses ).toBe @newAddresses

    it 'renders addresses list with passed addresses', ->
      @list = TestUtils.findRenderedComponentWithType @component, AddressesList

      expect( @list.props.addresses ).toBe @newAddresses

