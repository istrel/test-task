React         = require 'react'
Map           = require 'components/Map'
addresses     = require 'src/addresses'
AddressesList = require 'components/AddressesList'

TestTaskApp = React.createClass
  render: ->
    <div className='container'>
      <Map addresses={ addresses } />

      <AddressesList addresses={ addresses } />
    </div>

module.exports = TestTaskApp
