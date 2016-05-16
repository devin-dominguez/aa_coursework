var React = require('react');
var PokemonIndex = require('./pokemons/pokemonsIndex');

var App = React.createClass({

  render: function() {
    return (
      <div id="pokedex">
        <div className="pokemon-index-pane">
          <PokemonIndex />
        </div>
        {this.props.children}
      </div>
    );
  }

});

module.exports = App;
