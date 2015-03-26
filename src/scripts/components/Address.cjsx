React = require 'react'

Address = React.createClass
  distance: ->
    distance = @props.address.distance

    if distance < 1000
      "#{ Math.round(distance) } m"
    else
      "#{ Math.round(distance / 100) / 10 } km"

  render: ->
    <tr>
      <td>
        { @props.address.address }
      </td>
      <td>
        { @distance() }
      </td>
    </tr>

module.exports = Address
