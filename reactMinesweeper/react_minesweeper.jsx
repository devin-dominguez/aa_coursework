var React = require('react');
var ReactDOM = require('react-dom');
var Game = require('./components/game.jsx');

var Minesweeper = React.createClass({

  render: function() {
    return (
      <div className='minesweeper'>
        <Game />
      </div>
    );
  }

});

document.addEventListener("DOMContentLoaded", function() {
  ReactDOM.render(React.createElement(Minesweeper), document.getElementById('root'));
});

var React = require('react');
var PropTypes = React.PropTypes;
