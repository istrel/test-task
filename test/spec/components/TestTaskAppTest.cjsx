React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

App         = require 'components/App'
Map         = require 'components/Map'

describe 'App test', ->
  beforeEach ->
    @component = TestUtils.renderIntoDocument <App />

  it 'renders google map', ->
    TestUtils.findRenderedComponentWithType @component, Map
