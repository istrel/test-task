React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

AddressesList = require 'components/AddressesList.cjsx'
Address       = require 'components/Address.cjsx'

describe 'AddressesList component', ->
  it 'renders each passed address', ->
    @addresses = [
      address: 'First address'
      distance: 2
    ,
      address: 'Second address'
      distance: 1111
    ]

    @list = TestUtils.renderIntoDocument <AddressesList addresses={ @addresses } />

    @addrComponents = TestUtils.scryRenderedComponentsWithType @list, Address

    expect(@addrComponents.length).toBe(2)

    for addr, idx in @addrComponents
      [ addrLine, _ ] = TestUtils.scryRenderedDOMComponentsWithTag addr, 'td'

      expect( addrLine.getDOMNode().innerHTML ).toMatch @addresses[ idx ].address
