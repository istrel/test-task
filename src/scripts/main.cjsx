React = require 'react'
App   = require './components/App'

require 'styles/normalize.css'
require 'styles/main.styl'
require 'bootstrap-webpack!../bootstrap.config.js'

React.render <App addresses={ addresses }/>, document.getElementById('content')
