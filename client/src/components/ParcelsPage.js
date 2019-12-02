import React from "react"
import { Row, Col, Table } from "react-bootstrap"
import { NotificationManager } from "react-notifications"
import { NavLink } from "react-router-dom"
import { parcelPath } from "../helpers/routes"

export default class ParcelsPage extends React.PureComponent {
  state = {
    parcels: [],
  }

  componentDidMount () {
    this.fetchParcels()
  }

  fetchParcels = () => {
    fetch("/api/v1/parcels")
      .then(res => res.json())
      .then(response => this.setState({ parcels: response.data }))
      .catch(error => { NotificationManager.error(error) })
  }

  render() {
    const { parcels } = this.state
    const rows = parcels.map(parcel => (
      <tr key={parcel.code}>
        <th>{parcel.id}</th>
        <th>
          <NavLink to={parcelPath(parcel.code)}>{parcel.code}</NavLink>
        </th>
      </tr>
    ))

    return(
      <Row>
        <Col className="col-mt-3">
          <h3>Parcels</h3>
          <Table striped bordered hover>
            <thead>
            <tr>
              <th>#</th>
              <th>Parcel Code</th>
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
