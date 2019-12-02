import { invoicesPath } from "../helpers/routes"
import InvoicesPage from "../components/InvoicesPage"

export default {
  path: invoicesPath(),
  component: InvoicesPage,
  exact: true,
  strict: true,
}
