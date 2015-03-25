React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

config      = require 'config'
GoogleMaps  = require 'google-maps'
Map         = require 'components/Map.cjsx'

describe 'Map component', ->
  beforeEach ->
    @mapsApi =
      Map:    jasmine.createSpy 'Map'
      LatLng: jasmine.createSpy 'LatLng'
      Marker: jasmine.createSpy 'Marker'

    spyOn(GoogleMaps, 'load').and.callFake (cb) =>
      cb maps: @mapsApi

    @addresses = [
      address: 'First address'
      latitude: 0
      longitude: 1
    ,
      address: 'Second address'
      latitude: 2
      longitude: 3
    ]

    @component = TestUtils.renderIntoDocument <Map addresses={ @addresses } />

    @mapsApiCall = @mapsApi.Map.calls.mostRecent()

  it 'loads Google API with proper public key', ->
    expect(GoogleMaps.load).toHaveBeenCalledWith jasmine.any(Function),
      KEY: config.googleMapsKey

  it 'initializes element with map', ->
    expect(@mapsApi.Map).toHaveBeenCalledWith @component.getDOMNode(),
      zoom:   jasmine.any(Number),
      center: jasmine.any(@mapsApi.LatLng)

    context = @mapsApiCall.object

    expect( context instanceof @mapsApi.Map ).toBe true

  it 'draws every address', ->
    for addr in @addresses
      expect( @mapsApi.LatLng ).toHaveBeenCalledWith addr.latitude, addr.longitude

  describe '#drawAddress', ->
    beforeEach ->
      @component.drawAddress
        latitude: 12
        longitude: 34
        address: 'Test Address'

    it 'creates LatLng object', ->
      expect(@mapsApi.LatLng).toHaveBeenCalledWith 12, 34

    it 'creates marker for created LatLng object', ->
      expect(@mapsApi.Marker).toHaveBeenCalledWith
        position: jasmine.any(@mapsApi.LatLng)
        map: jasmine.any(@mapsApi.Map)
        title: 'Test Address'

      context = @mapsApi.Marker.calls.mostRecent().object

      expect( context instanceof @mapsApi.Marker ).toBe true
