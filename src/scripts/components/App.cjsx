React         = require 'react'
Map           = require 'components/Map'
addresses     = require 'src/addresses'
AddressesList = require 'components/AddressesList'

App = React.createClass
  getInitialState: ->
    filteredAddresses: []

  render: ->
    <div className='container'>
      <Map addresses={ @state.filteredAddresses } />

      <AddressesList addresses={ @state.filteredAddresses } />
    </div>

module.exports = App
