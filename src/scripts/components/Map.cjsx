React      = require 'react'
GoogleMaps = require 'google-maps'
config     = require 'config'

Map = React.createClass
  componentDidMount: ->
    GoogleMaps.load ({ maps }) =>
      new maps.Map @getDOMNode(),
        zoom: 1
        center: new maps.LatLng(-34.397, 150.644)
    , KEY: config.googleMapsKey

  render: ->
    <div className="map well">
    </div>

module.exports = Map
