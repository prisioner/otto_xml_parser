import React from "react"
import { Form, Button } from "react-bootstrap"
import PropTypes from "prop-types"

export default class BatchFileForm extends React.PureComponent {
  static propTypes = {
    onSubmit: PropTypes.func.isRequired,
  }

  render() {
    return (
      <Form onSubmit={this.props.onSubmit}>
        <Form.Group controlId="formBatchFile">
          <Form.Label>XML File</Form.Label>
          <Form.Control
            type="file"
            name="batch_file[file]"
            placeholder="XML File"
          />
        </Form.Group>
        <Button variant="primary" type="submit">
          Submit
        </Button>
      </Form>
    )
  }
}
