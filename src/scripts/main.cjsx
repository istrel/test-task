React = require 'react'
App   = require './components/App'

require 'styles/normalize.css'
require 'styles/main.styl'
require 'bootstrap-webpack!../bootstrap.config.js'

addresses = require 'src/addresses'

React.render <App addresses={ addresses }/>, document.getElementById('content')
