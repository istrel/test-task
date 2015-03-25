React         = require 'react'
_             = require 'underscore'
Map           = require 'components/Map'
AddressesList = require 'components/AddressesList'
Mediator      = require '../Mediator'
PolarDistance = require 'helpers/PolarDistance'
config        = require 'config'

App = React.createClass
  initialize: ->
    Mediator.on 'setPosition', (point) =>
      filteredAddresses = []

      for addr in @props.addresses
        distance = PolarDistance(
          [ point.latitude, point.longitude ]
          [ addr.latitude, addr.longitude ]
        )

        if distance < config.searchRadius
          filteredAddresses.push _({ distance }).extend addr

      @setState { filteredAddresses }

  getInitialState: ->
    @initialize()

    filteredAddresses: []

  render: ->
    <div className='container'>
      <Map addresses={ @state.filteredAddresses } />

      <AddressesList addresses={ @state.filteredAddresses } />
    </div>

module.exports = App
