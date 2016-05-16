var React = require('react');
var PokemonStore = require('../../stores/pokemon');
var ApiUtil = require('../../util/apiUtil');
var ToysIndex = require('./toys/toysIndex');
var PokemonDetail = React.createClass({

  getInitialState: function() {
    return {
      pokemonDetail: this.getStateFromStore()
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
      pokemonDetail: this.getStateFromStore()
    });
  },

  getStateFromStore: function() {
    var id = parseInt(this.props.params.pokemonId);
    return PokemonStore.find(id);
  },

  componentWillReceiveProps: function (newProps) {
    var id = newProps.params.pokemonId;
    ApiUtil.fetchSinglePokemon(id);
  },

  renderDetails: function() {
    return (
      <div className="detail">
        <h3>Name:</h3> {this.state.pokemonDetail.name} <br />
        <h3>Type:</h3> {this.state.pokemonDetail.poke_type} <br />
        <h3>Moves:</h3> {this.state.pokemonDetail.moves.join(", ")} <br />
        <h3>Attack:</h3> {this.state.pokemonDetail.attack} <br />
        <h3>Defense:</h3> {this.state.pokemonDetail.defense} <br />
        <img src={this.state.pokemonDetail.image_url} />
      </div>
    );
  },

  render: function() {

    return (
      <div>
        <div className="pokemon-detail-pane">

          {(this.state.pokemonDetail) ?
            this.renderDetails() :
            <div className="detail"/>}

          <ToysIndex toys={this.state.pokemonDetail ?
            this.state.pokemonDetail.toys : ""}/>

        </div>
        {this.props.children}
      </div>
    );
  }

});

module.exports = PokemonDetail;
