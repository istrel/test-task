React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'
q           = require 'q'
_           = require 'underscore'

Marker      = require 'components/Marker.cjsx'

describe 'Marker', ->
  beforeEach ->
    @mapsApi =
      Map:    jasmine.createSpy 'Map'
      LatLng: jasmine.createSpy 'LatLng'
      Marker: jasmine.createSpy 'Marker'

    @mapsApi.Marker::setMap = jasmine.createSpy 'setMap'

    @map = new @mapsApi.Map()

    @mapDefer = q.defer()
    @apiDefer = q.defer()

    @addr =
      address: 'Test address'
      latitude: 2
      longitude: 3

    @component = TestUtils.renderIntoDocument(
      <Marker
        address={ @addr }
        mapPromise={ q.resolve @map }
        apiPromise={ q.resolve @mapsApi }
      />
    )

  it 'creates google maps marker on API and map load', (done) ->
    _.defer =>
      expect( @mapsApi.LatLng ).toHaveBeenCalledWith @addr.latitude, @addr.longitude

      expect( @mapsApi.Marker ).toHaveBeenCalledWith
        position: jasmine.any( @mapsApi.LatLng )
        title: @addr.address
        map: @map

      done()

  it 'removes marker before detaching', (done) ->
    _.defer =>
      @component.componentWillUnmount()

      expect( @mapsApi.Marker::setMap ).toHaveBeenCalledWith null

      done()
