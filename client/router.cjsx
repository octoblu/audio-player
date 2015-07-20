React = require('react')
Router = require('react-router')
{ Redirect, Route, RouteHandler, Link, DefaultRoute, NotFoundRoute } = Router

App = require('./app')
Player = require('./components/player')


routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={Player} />
  </Route>


Router.run routes, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
