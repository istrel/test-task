React  = require 'react'
Map    = require 'components/Map'
points = require '../../points'
AddressesList = require 'components/AddressesList'

TestTaskApp = React.createClass
  render: ->
    <div className='container'>
      <Map />

      <AddressesList addresses={ points } />
    </div>

module.exports = TestTaskApp
