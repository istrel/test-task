React   = require 'react'
Address = require 'components/Address'

AddressesList = React.createClass
  addresses: ->
    for addr in @props.addresses
      <Address address={ addr } />

  render: ->
    <div className="panel panel-default">
      <table className="table">
        <tr>
          <th className="col-sm-9">Address</th>
          <th className="col-sm-3">Distance</th>
        </tr>

        { @addresses() }
      </table>
    </div>

module.exports = AddressesList
