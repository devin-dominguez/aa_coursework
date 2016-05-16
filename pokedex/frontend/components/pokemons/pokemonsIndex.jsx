var React = require('react');
var PokemonStore = require('../../stores/pokemon');
var ApiUtil = require('../../util/apiUtil');

var PokemonIdexItem = require('./pokemonIndexItem');

var PokemonsIndex = React.createClass({
  getInitialState: function () {
    return {
      pokemons: []
    };
  },

  componentDidMount: function () {
    this.pokemonStoreToken = PokemonStore.addListener(this._onChange);
    ApiUtil.fetchAllPokemons();
  },

  componentWillUnmount: function () {
    this.pokemonStoreToken.remove();
  },

  _onChange: function () {
    this.setState({
      pokemons: PokemonStore.all()
    });
  },

  render: function() {
    var pokemonIndexItems = this.state.pokemons.map(function (pokemon, idx) {
      return <PokemonIdexItem key={idx} pokemon={pokemon}/>;
    });

    return (
      <ul>
        {pokemonIndexItems}
      </ul>
    );
  }

});

module.exports = PokemonsIndex;
