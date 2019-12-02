import React from "react"
import { Row, Col, Table } from "react-bootstrap"
import { NotificationManager } from "react-notifications"
import { NavLink } from "react-router-dom"
import { invoicePath } from "../helpers/routes"

export default class InvoicesPage extends React.PureComponent {
  state = {
    invoices: [],
  }

  componentDidMount () {
    this.fetchInvoices()
  }

  fetchInvoices = () => {
    fetch("/api/v1/invoices")
      .then(res => res.json())
      .then(response => this.setState({ invoices: response.data }))
      .catch(error => { NotificationManager.error(error) })
  }

  render() {
    const { invoices } = this.state
    const rows = invoices.map(invoice => (
      <tr key={invoice.operation_number}>
        <th>{invoice.id}</th>
        <th>
          <NavLink to={invoicePath(invoice.operation_number)}>{invoice.operation_number}</NavLink>
        </th>
        <th>{invoice.operation_date}</th>
        <th>{invoice.company_code}</th>
      </tr>
    ))

    return(
      <Row>
        <Col className="col-mt-3">
          <h3>Invoices</h3>
          <Table striped bordered hover>
            <thead>
            <tr>
              <th>#</th>
              <th>Invoice Operation Number</th>
              <th>Invoice Operation Date</th>
              <th>Company Code</th>
            </tr>
            </thead>
            <tbody>
              {rows}
            </tbody>
          </Table>
        </Col>
      </Row>
    )
  }
}
