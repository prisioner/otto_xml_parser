import React, { Fragment } from "react"
import { Row, Col } from "react-bootstrap"
import Form from "./BatchFile/Form"
import Table from "./BatchFile/Table"
import Axios from "axios"
import { NotificationManager } from "react-notifications"

export default class MainPage extends React.PureComponent {
  state = {
    batch_files: [],
  }

  componentDidMount () {
    this.fetchBatchFiles()
  }

  fetchBatchFiles = () => {
    fetch("/api/v1/batch_files")
      .then(res => res.json())
      .then((response) => this.setState({ batch_files: response.data }))
      .catch((error) => { NotificationManager.error(error) })
  }

  submitForm = (event) => {
    event.preventDefault();
    let formData = new FormData(event.target);
    event.target.querySelector("input").value = ""

    Axios.post("/api/v1/batch_files", formData)
      .then(res => {
        NotificationManager.success(`File has been uploaded and saved with id=${res.data.batch_file.id}`, "Success")
      })
      .catch(err => {
        console.error(err)
        NotificationManager.error("Something going wrong")
      })
  }

  statusClass = (status) => {
    switch (status) {
      case "success":
        return "text-success"
        break
      case "pending":
        return "text-warning"
        break
      case "error":
        return "text-danger"
        break
      case "duplicate":
        return "text-info"
        break
      default:
        return "text-dark"
    }
  }

  render() {
    const { batch_files } = this.state
    const rows = batch_files.map(file => (
      <tr key={file.id}>
        <td>{file.id}</td>
        <td>{file.file_guid}</td>
        <td>{file.batch_guid}</td>
        <td><span className={this.statusClass(file.status)}>{file.status}</span></td>
      </tr>
    ))

    return(
      <Fragment>
        <Row className="mt-3">
          <Col>
            <Form onSubmit={this.submitForm} />
          </Col>
        </Row>

        <Row className="mt-3">
          <Col>
            <Table rows={rows} />
          </Col>
        </Row>
      </Fragment>
    )
  }
}
