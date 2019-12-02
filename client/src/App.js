import React, { Fragment } from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom"
import MainMenu from "./components/MainMenu"
import routes from "./routes"
import { Container } from "react-bootstrap"
import { NotificationContainer } from "react-notifications"

const RouteWithSubroutes = (route, key) => <Route key={key} { ...route } />

const App = () => {
  return (
    <Container>
      <NotificationContainer />
      <Router>
        <Fragment>
          <MainMenu />
          <Switch>
            { routes.map((route, key) => RouteWithSubroutes(route, key)) }
          </Switch>
        </Fragment>
      </Router>
    </Container>
  )
}

export default App;
