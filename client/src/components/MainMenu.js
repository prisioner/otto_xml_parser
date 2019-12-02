import React from "react"
import { NavLink } from "react-router-dom"
import { mainPath, parcelsPath, invoicesPath, contactsPath } from "../helpers/routes"
import { Nav, Navbar } from "react-bootstrap"

const MainMenu = () => {
  return(
    <Navbar bg="light" expand="lg">
      <Navbar.Brand>XML Parser</Navbar.Brand>
      <Navbar.Toggle aria-controls="basic-navbar-nav" />
      <Navbar.Collapse>
        <Nav className="mr-auto">
          <Nav.Item className="nav-link"><NavLink to={mainPath()}>Main</NavLink></Nav.Item>
          <Nav.Item className="nav-link"><NavLink to={invoicesPath()}>Invoices</NavLink></Nav.Item>
          <Nav.Item className="nav-link"><NavLink to={parcelsPath()}>Parcels</NavLink></Nav.Item>
          <Nav.Item className="nav-link"><NavLink to={contactsPath()}>Contacts</NavLink></Nav.Item>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  )
}

export default MainMenu
