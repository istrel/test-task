React       = require 'react'
TestUtils   = require 'react/lib/ReactTestUtils'

Address = require 'components/Address.cjsx'

describe 'Address component', ->
  describe '#distance', ->
    it 'returns meters for values less than 1000', ->
      @component = TestUtils.renderIntoDocument <Address address={ distance: 5 }/>

      expect( @component.distance() ).toBe "5 m"

    it 'returns kilometers for values greater than 1000', ->
      @component = TestUtils.renderIntoDocument <Address address={ distance: 1499 }/>

      expect( @component.distance() ).toBe "1.5 km"

  it 'renders proper line', ->
    @address =
      address: 'Test Address'
      distance: 5

    @component = TestUtils.renderIntoDocument(
      <table>
        <Address address={ @address }/>
      </table>
    )

    @row = TestUtils.findRenderedComponentWithType @component, Address

    [ @addrField, @distField ] = TestUtils.scryRenderedDOMComponentsWithTag @row, 'td'

    expect(@addrField.getDOMNode().innerHTML).toMatch @address.address

    expect(@distField.getDOMNode().innerHTML).toMatch @row.distance()



