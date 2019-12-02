import React from "react"
import { Row, Col, Table } from "react-bootstrap"
import NotFoundPage from "./NotFoundPage"
import { NotificationManager } from "react-notifications"
import { NavLink } from "react-router-dom"
import { invoicePath } from "../helpers/routes"

export default class ParcelPage extends React.PureComponent {
  state = {
    parcel: {},
    parcel_items: [],
    error: null,
  }

  componentDidMount() {
    this.fetchParcel()
  }

  fetchParcel = () => {
    const { parcelCode } = this.props

    fetch(`/api/v1/parcels/${parcelCode}`)
      .then(res => res.json())
      .then(response => this.setState({
        parcel: response.parcel,
        parcel_items: response.parcel_items,
        error: response.error,
      }))
      .catch(error => { NotificationManager.error(error) })
  }

  render() {
    const { parcelCode } = this.props
    const { parcel_items, error } = this.state

    if (error) {
      return <NotFoundPage />
    }

    const rows = parcel_items.map(item => (
      <tr key={item.invoice}>
        <td><NavLink to={invoicePath(item.invoice)}>{item.invoice}</NavLink></td>
        <td>{item.quantity}</td>
        <td>{item.parcel_price}</td>
      </tr>
    ))

    return(
      <Row>
        <Col>
          <h3>Invoice #{parcelCode}</h3>
          <Table striped bordered hover>
            <thead>
            <tr>
              <th>Invoice Operation Number</th>
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
