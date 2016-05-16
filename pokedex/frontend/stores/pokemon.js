var Dispatcher = require('../dispatcher/dispatcher');
var Store = require('flux/utils').Store;
var PokemonConstants = require('../constants/pokemonConstants');

var _pokemons = {};

var PokemonStore = new Store(Dispatcher);

PokemonStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case PokemonConstants.POKEMONS_RECIEVED:
      resetPokemons(payload.pokemons);
      this.__emitChange();
      break;
    case PokemonConstants.POKEMON_RECIEVED:
      updatePokemonWithDetails(payload.pokemon);
      this.__emitChange();
      break;
  }
};

PokemonStore.all = function () {
  var results = [];
  for (var id in _pokemons) {
    results.push(_pokemons[id]);
  }
  return results;
};

PokemonStore.find = function(id) {
  return _pokemons[id];
};

PokemonStore.findToy = function(pokeId, toyId) {
  var toysAry = this.find(pokeId).toys;
  for (var i = 0; i < toysAry.length; i++) {
    if (toysAry[i].id === toyId) {
      return toysAry[i];
    }
  }
};

var updatePokemonWithDetails = function (pokemon) {
  _pokemons[pokemon.id] = pokemon;
};

var resetPokemons = function (pokemons) {
  _pokemons = {};
  pokemons.forEach(function (pokemon) {
    _pokemons[pokemon.id] = pokemon;
  });
};

module.exports = PokemonStore;
