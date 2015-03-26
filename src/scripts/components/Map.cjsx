React      = require 'react'
GoogleMaps = require 'google-maps'
config     = require 'config'
q          = require 'q'
Mediator   = require '../Mediator'
Marker     = require 'components/Marker'

Map = React.createClass
  componentDidMount: ->
    GoogleMaps.load ({ maps }) =>
      @mapsAPI = maps

      @map = new maps.Map @getDOMNode(),
        zoom: 10
        center: new maps.LatLng 55.7, 37.8

      @mapsAPI.event.addListener @map, 'click', (evt) =>
        @setMarker evt.latLng

      @apiDefer.resolve @mapsAPI
      @mapDefer.resolve @map

    , KEY: config.googleMapsKey

  setMarker: (position) ->
    latitude = position.lat()
    longitude = position.lng()

    if @marker
      @marker.setPosition position
    else
      @marker = new @mapsAPI.Marker
        position: position
        map: @map
        icon:
          path: @mapsAPI.SymbolPath.CIRCLE
          scale: 3

    Mediator.emit 'setPosition', { latitude, longitude }

  markers: ->
    for addr, idx in @props.addresses
      <Marker
        key={ idx }
        address={ addr }
        mapPromise={ @mapDefer.promise }
        apiPromise={ @apiDefer.promise }
      />

  render: ->
    @mapDefer ?= q.defer()
    @apiDefer ?= q.defer()

    <div className="map well">
      { @markers() }
    </div>

module.exports = Map
