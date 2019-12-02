import React from "react"
import { Table } from "react-bootstrap"
import PropTypes from "prop-types"

export default class BatchFileTable extends React.PureComponent {
  static propTypes = {
    rows: PropTypes.array.isRequired,
  }

  render() {
    return (
      <Table striped bordered hover>
        <thead>
        <tr>
          <th>#</th>
          <th>File GUID</th>
          <th>Batch ID</th>
          <th>Status</th>
        </tr>
        </thead>
        <tbody>
          {this.props.rows}
        </tbody>
      </Table>
    )
  }
}
