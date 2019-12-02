import React from "react"
import { invoicePath } from "../helpers/routes"
import InvoicePage from "../components/InvoicePage"

export default {
  path: invoicePath(),
  exact: true,
  strict: true,
  render: ({ match }) => {
    return (
      <InvoicePage invoiceOperationNumber={match.params.id} />
    )
  }
}
