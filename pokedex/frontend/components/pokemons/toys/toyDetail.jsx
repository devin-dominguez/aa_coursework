var React = require('react');
var PokemonStore = require('../../../stores/pokemon');

var ToyDetail = React.createClass({

  getInitialState: function() {
    return {
      toyDetail: this.getStateFromStore(this.props.params)
    };
  },

  componentDidMount: function() {
    this.pokemonStoreToken = PokemonStore.addListener(this._onChange);
  },

  componentWillUnmount: function() {
    this.pokemonStoreToken.remove();
  },

  _onChange: function() {
    this.setState({
      toyDetail: this.getStateFromStore(this.props.params)
    });
  },

  getStateFromStore: function(params) {
    var pokeId = parseInt(params.pokemonId);
    var toyId = parseInt(params.toyId);
    var pokemon = PokemonStore.find(pokeId);

    if (pokemon && pokemon.toys) {
      return PokemonStore.findToy(pokeId, toyId);
    }
  },

  componentWillReceiveProps: function (newProps) {
    var toyDetail = this.getStateFromStore(newProps.params);

    this.setState({
      toyDetail: toyDetail
    });
  },

  render: function() {
    var toy = this.state.toyDetail || {};

    return (
      <div>
        <h3>Name:</h3> {toy.name} <br />
        <h3>Happiness:</h3> {toy.happiness} <br />
        <h3>Price:</h3> {toy.price} <br />
        <img src={toy.image_url} />
      </div>
    );
  }

});



module.exports = ToyDetail;
