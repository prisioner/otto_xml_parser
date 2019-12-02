import { parcelsPath } from "../helpers/routes"
import ParcelsPage from "../components/ParcelsPage"

export default {
  path: parcelsPath(),
  component: ParcelsPage,
  exact: true,
  strict: true,
}
