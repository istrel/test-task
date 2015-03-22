React = require 'react'
Map   = require 'components/Map'

TestTaskApp = React.createClass
  render: ->
    <div className='container'>
      <Map />
    </div>

module.exports = TestTaskApp
