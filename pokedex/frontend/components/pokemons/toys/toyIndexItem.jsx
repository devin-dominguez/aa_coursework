var React = require('react');
var History = require('react-router').History;

var ToyIndexItem = React.createClass({
  mixins: [History],

  clickHandler: function () {
    this.history.push("/pokemon/" +
      this.props.toy.pokemon_id +
      "/toys/" + this.props.toy.id);
  },

  render: function() {
    return (
      <li onClick={this.clickHandler} className="toy-list-item">
        <h3>Name:</h3> {this.props.toy.name} <br />
        <h3>Happiness:</h3> {this.props.toy.happiness} <br />
        <h3>Price:</h3> {this.props.toy.price} <br />
      </li>
    );
  }

});

module.exports = ToyIndexItem;
