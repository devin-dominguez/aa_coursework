var Dispatcher = require('../dispatcher/dispatcher');
var PokemonConstants = require('../constants/pokemonConstants');

var PokemonActions = {
  receiveSinglePokemon: function (singlePokemon) {
    var action = {
      actionType: PokemonConstants.POKEMON_RECIEVED,
      pokemon: singlePokemon
    };

    Dispatcher.dispatch(action);
  },
  receiveAllPokemons: function (pokemonArr) {
    var action = {
      actionType: PokemonConstants.POKEMONS_RECIEVED,
      pokemons: pokemonArr
    };

    Dispatcher.dispatch(action);
  }
};

module.exports = PokemonActions;
