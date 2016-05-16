var React = require('react');
var ReactDOM = require('react-dom');
var PokemonsIndex = require('./components/pokemons/pokemonsIndex');
var Router = require('react-router').Router;
var Route = require('react-router').Route;
var App = require('./components/app');
var PokemonDetail = require('./components/pokemons/pokemonDetail');
var ToyDetail = require('./components/pokemons/toys/toyDetail');



window.Pokemon = require('./stores/pokemon');

window.apiUtil = require('./util/apiUtil');

var routes = (
  <Route component={App} path="/">
    <route component={PokemonDetail} path="pokemon/:pokemonId">
      <route component={ToyDetail} path="toys/:toyId"></route>
    </route>
  </Route>
);

$(function () {
  ReactDOM.render(<Router>{routes}</Router>, $("#root")[0]);
});
