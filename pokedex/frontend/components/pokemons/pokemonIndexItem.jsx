var React = require('react');
var History = require('react-router').History;
var ApiUtil = require('../../util/apiUtil');

var PokemonIndexItem = React.createClass({
  mixins: [History],

  showDetail: function() {
    var id = this.props.pokemon.id;
    this.history.push("pokemon/" + id);
  },

  render: function() {
    return (
      <li onClick={this.showDetail} className="poke-list-item">
        Name: {this.props.pokemon.name}
        <br/>
        Type: {this.props.pokemon.poke_type}
      </li>
    );
  }

});

module.exports = PokemonIndexItem;
