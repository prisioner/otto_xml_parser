import React from "react"
import { parcelPath } from "../helpers/routes"
import ParcelPage from "../components/ParcelPage"

export default {
  path: parcelPath(),
  exact: true,
  strict: true,
  render: ({ match }) => {
    return (
      <ParcelPage parcelCode={match.params.id} />
    )
  }
}
