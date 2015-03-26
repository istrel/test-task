React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

config      = require 'config'
GoogleMaps  = require 'google-maps'
Map         = require 'components/Map'

Marker      = require 'components/Marker'
Mediator    = require 'src/scripts/Mediator'

describe 'Map component', ->
  beforeEach ->
    @mapsApi =
      Map:    jasmine.createSpy 'Map'
      LatLng: jasmine.createSpy 'LatLng'
      Marker: jasmine.createSpy 'Marker'
      event:
        addListener: (@evtListener, @evtName, @evtCallback) =>
      SymbolPath: {}

    spyOn(GoogleMaps, 'load').and.callFake (cb) =>
      cb maps: @mapsApi

    @mapsApi.Marker::setPosition = jasmine.createSpy 'setPosition'

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

    @mapsApiCall = @mapsApi.Map.calls.first()

    @map = @mapsApiCall.object

    expect( @map instanceof @mapsApi.Map ).toBe true

  it 'loads Google API with proper public key', ->
    expect(GoogleMaps.load).toHaveBeenCalledWith jasmine.any(Function),
      KEY: config.googleMapsKey

  it 'initializes element with map', ->
    expect(@mapsApi.Map).toHaveBeenCalledWith @component.getDOMNode(),
      zoom:   jasmine.any(Number),
      center: jasmine.any(@mapsApi.LatLng)

  it 'creates deferred for google API', (done) ->
    @component.apiDefer.promise.then (api) =>
      expect(api).toBe @mapsApi

      done()

  it 'creates deferred for map', (done) ->
    @component.mapDefer.promise.then (map) =>
      expect(map).toBe @map

      done()

  describe 'marker', ->
    beforeEach ->
      @markers = TestUtils.scryRenderedComponentsWithType @component, Marker

    it 'has address', ->
      for addr, idx in @addresses
        marker = @markers[ idx ]

        expect( marker.props.address ).toBe addr

    it 'has map promise', ->
      for marker in @markers
        expect( marker.props.mapPromise ).toBe @component.mapDefer.promise

    it 'has api promise', ->
      for marker in @markers
        expect( marker.props.apiPromise ).toBe @component.apiDefer.promise

  describe 'on click', ->
    beforeEach ->
      @latLng =
        lat: -> 2
        lng: -> 3

      @evtCallback { @latLng }

    it 'reacts only on map click events', ->
      expect(@evtListener).toBe @map
      expect(@evtName).toBe 'click'

    it 'renders marker', ->
      expect( @mapsApi.Marker ).toHaveBeenCalledWith
        position: @latLng
        map: @map
        icon: jasmine.any(Object)

    it 'emits change event', (done) ->
      Mediator.once 'setPosition', ({ latitude, longitude }) =>
        expect( latitude ).toBe @latLng.lat()
        expect( longitude ).toBe @latLng.lng()

        done()

      @evtCallback { @latLng }


    it 'reposition marker on second click', ->
      expect( @mapsApi.Marker::setPosition ).not.toHaveBeenCalled()

      @evtCallback { @latLng }

      expect( @mapsApi.Marker::setPosition ).toHaveBeenCalledWith @latLng
