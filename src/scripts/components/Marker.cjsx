React = require 'react'
q     = require 'q'

module.exports = React.createClass
  componentDidMount: ->
    addr = @props.address

    q.all([ @props.apiPromise, @props.mapPromise ])
      .then ([ @mapsAPI, @map ]) =>
        position = new @mapsAPI.LatLng addr.latitude, addr.longitude

        @marker = new @mapsAPI.Marker
          position: position
          title: addr.address
          map: @map

  componentWillUnmount: ->
    @marker.setMap null

  render: ->
    null
