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

    spyOn(GoogleMaps, 'load').and.callFake (cb) =>
      cb maps: @mapsApi

    @component = TestUtils.renderIntoDocument <Map />

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
