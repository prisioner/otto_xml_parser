import React from "react"
import { Row, Col, Table } from "react-bootstrap"
import NotFoundPage from "./NotFoundPage"
import { NotificationManager } from "react-notifications"
import { NavLink } from "react-router-dom"
import { parcelPath } from "../helpers/routes"

export default class InvoicePage extends React.PureComponent {
  state = {
    invoice: {},
    parcel_items: [],
    error: null,
  }

  componentDidMount() {
    this.fetchInvoice()
  }

  fetchInvoice = () => {
    const { invoiceOperationNumber } = this.props

    fetch(`/api/v1/invoices/${invoiceOperationNumber}`)
      .then(res => res.json())
      .then(response => this.setState({
        invoice: response.invoice,
        parcel_items: response.parcel_items,
        error: response.error,
      }))
      .catch(error => { NotificationManager.error(error) })
  }

  render() {
    const { invoiceOperationNumber } = this.props
    const { parcel_items, error } = this.state

    if (error) {
      return <NotFoundPage />
    }

    const rows = parcel_items.map(item => (
      <tr key={item.parcel_code}>
        <td><NavLink to={parcelPath(item.parcel_code)}>{item.parcel_code}</NavLink></td>
        <td>{item.quantity}</td>
        <td>{item.parcel_price}</td>
      </tr>
    ))

    return(
      <Row>
        <Col>
          <h3>Invoice #{invoiceOperationNumber}</h3>
          <Table striped bordered hover>
            <thead>
            <tr>
              <th>Parcel Code</th>
              <th>Quantity</th>
              <th>Parcel Price</th>
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
