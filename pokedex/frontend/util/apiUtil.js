var PokemonActions = require('../actions/pokemonActions');


var apiUtil = {
  fetchSinglePokemon: function (id) {
    var options = {
        url: "api/pokemon/" + id,
        type: "GET",
        success: function (resp) {
        PokemonActions.receiveSinglePokemon(resp);
        },
        error: function (resp) {
          console.log(resp);
        }
    };

    $.ajax(options);
  },
  fetchAllPokemons: function () {
    var options = {
        url: "api/pokemon",
        type: "GET",
        success: function (resp) {
        PokemonActions.receiveAllPokemons(resp);
        },
        error: function (resp) {
          console.log(resp);
        }
    };

    $.ajax(options);
  }
};

module.exports = apiUtil;
