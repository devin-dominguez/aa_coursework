var React = require('react');
var Tile = require('./tile.jsx');
var Minesweeper = require('../minesweeper.js');

var Board = React.createClass({

  render: function() {
    var self = this;
    return (
      <div className='board'>
        {
        this.props.board.grid.map(function(row, rowIdx){
          return <div key={rowIdx} className='row'> {
              row.map(function(tile, colIdx) {
                return <Tile tile={tile} updateGame={self.props.updateGame} key={colIdx}/>;
              })
            } </div>;
        })
        }
      </div>
    );
  }

});

module.exports = Board;
