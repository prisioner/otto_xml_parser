import React, { Fragment } from 'react';
import { BrowserRouter as Router, Route, Switch } from "react-router-dom"
import MainMenu from "./components/MainMenu"
import routes from "./routes"

const RouteWithSubroutes = (route, key) => <Route key={key} { ...route } />

const App = () => {
  return (
    <Router>
      <Fragment>
        <MainMenu />
        <Switch>
          { routes.map((route, key) => RouteWithSubroutes(route, key)) }
        </Switch>
      </Fragment>
    </Router>
  )
}

export default App;
