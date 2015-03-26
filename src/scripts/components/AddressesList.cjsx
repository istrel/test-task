React   = require 'react'
Address = require 'components/Address'

AddressesList = React.createClass
  addresses: ->
    for addr, idx in @props.addresses
      <Address key={ idx } address={ addr } />

  table: ->
    <table className="table">
      <thead>
        <th className="col-sm-9">Address</th>
        <th className="col-sm-3">Distance</th>
      </thead>

      <tbody>
        { @addresses() }
      </tbody>
    </table>

  noAddresses: ->
    <div className="panel-body">
      No addresses
    </div>

  render: ->
    body = if @props.addresses.length then @table() else @noAddresses()

    <div className="panel panel-default">
      { body }
    </div>

module.exports = AddressesList
