React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

AddressesList = require 'components/AddressesList.cjsx'
Address       = require 'components/Address.cjsx'

describe 'AddressesList component', ->
  describe 'with any addresses passed', ->
    beforeEach ->
      @addresses = [
        address: 'First address'
        distance: 2
      ,
        address: 'Second address'
        distance: 1111
      ]

      @list = TestUtils.renderIntoDocument <AddressesList addresses={ @addresses } />

    it 'renders each passed address', ->
      @addrComponents = TestUtils.scryRenderedComponentsWithType @list, Address

      expect(@addrComponents.length).toBe(2)

      for addr, idx in @addrComponents
        [ addrLine, _ ] = TestUtils.scryRenderedDOMComponentsWithTag addr, 'td'

        expect( addrLine.getDOMNode().innerHTML ).toMatch @addresses[ idx ].address

    it 'does not render panel body', ->
      bodys = TestUtils.scryRenderedDOMComponentsWithClass @list, 'panel-body'

      expect(bodys).toEqual []

  describe 'with no addresses', ->
    beforeEach ->
      @list = TestUtils.renderIntoDocument <AddressesList addresses={ [] } />

    it 'renders empty panel when there is no addresses', ->
      tables = TestUtils.scryRenderedDOMComponentsWithTag @list, 'table'

      expect( tables ).toEqual []

    it 'renders panel body', ->
      TestUtils.findRenderedDOMComponentWithClass @list, 'panel-body'



