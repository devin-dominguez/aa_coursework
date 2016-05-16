var React = require('react');
var Board = require('./board.jsx');
var Minesweeper = require('../minesweeper.js');


var Game = React.createClass({
  getInitialState: function() {
    return { board: new Minesweeper.Board(10, 10),
             gameOverText: "",
             modalClass: "modal-off"
           };
  },

  updateGame: function(tile, toggleFlag) {
    if (toggleFlag) {
      tile.toggleFlag();
    } else {
      tile.explore();
    }
    this.setState({
      board: this.state.board
    });

    if (this.state.board.won() ){
      this.gameOver();
      this.setState({ gameOverText: "You win!"});
    } else if (this.state.board.lost() ) {
      this.gameOver();
      this.setState({ gameOverText: "You lose :("});
    }
  },

  gameOver: function() {
    this.setState({ modalClass: "modal-on"});
    this.state.board.grid.forEach(function(row) {
      row.forEach(function(tile) {
          tile.explore();
      });
    });
  },

  restartGame: function(e) {
    e.preventDefault();
    this.setState({ board: new Minesweeper.Board(10, 10),
                    gameOverText: "",
                    modalClass: "modal-off"
                  });
  },

  render: function() {

    return (
      <div className='game'>
        <Board board={this.state.board} updateGame={this.updateGame}/>
        <div className={this.state.modalClass}>
          <div className="modal-content">
            {this.state.gameOverText}
            <button className="modal-button" onClick={this.restartGame}>Restart Game</button>
          </div>
          <div className="modal-screen">
          </div>
        </div>

      </div>
    );
  }

});

module.exports = Game;
