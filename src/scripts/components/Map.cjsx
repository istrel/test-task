React      = require 'react'
GoogleMaps = require 'google-maps'
config     = require 'config'

Map = React.createClass
  drawAddress: (addr) ->
    position = new @_mapsAPI.LatLng addr.latitude, addr.longitude

    new @_mapsAPI.Marker
      position: position
      map: @map
      title: addr.address

  componentDidMount: ->
    GoogleMaps.load ({ maps }) =>
      @_mapsAPI = maps

      @map = new maps.Map @getDOMNode(),
        zoom: 10
        center: new maps.LatLng 55.7, 37.8

      @drawAddress addr for addr in @props.addresses

    , KEY: config.googleMapsKey


  render: ->
    <div className="map well">
    </div>

module.exports = Map
