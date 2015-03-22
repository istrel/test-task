'use strict'

React = require('react/addons')
ReactTransitionGroup = React.addons.TransitionGroup

# CSS
require('../../styles/normalize.css')
require('../../styles/main.css')

imageURL = require('../../images/yeoman.png')

TestTaskApp = React.createClass
  render: ->
    <div className='main'>
      <ReactTransitionGroup transitionName="fade">
        <img src={imageURL} />
      </ReactTransitionGroup>
    </div>

React.render(<TestTaskApp />, document.getElementById('content')) # jshint ignore:line

module.exports = TestTaskApp
