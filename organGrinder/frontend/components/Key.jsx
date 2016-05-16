var React = require('react');
var Note = require("../util/Note");
var TONES = require("../constants/Tones");
var keyStore = require('../stores/KeyStore');

var Key = React.createClass({
  getInitialState: function () {
    return {pressed: false};
  },

  componentDidMount: function() {
    var freq = TONES[this.props.noteName];
    this.note = new Note(freq);
    this.listener = keyStore.addListener(this._checkCurrentNotes);
  },

  _checkCurrentNotes: function() {
    var pressed = keyStore.allNotes().some(function (note) {
      return note === this.props.noteName;
    }, this);
    if (pressed) {

      this.note.start();
    } else {

      this.note.stop();
    }
    this.setState({pressed: pressed});
  },

  componentWillUnmount: function () {
    this.listener.remove();
  },

  render: function() {
    var style = {backgroundColor: this.state.pressed ? "red" : "transparent"};
    return (
      <div style={style}>{this.props.noteName}</div>
    );
  }

});

module.exports = Key;
