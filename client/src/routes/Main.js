import { mainPath } from "../helpers/routes"
import MainPage from "../components/MainPage"

export default {
  path: mainPath(),
  component: MainPage,
  exact: true,
  strict: true,
}
