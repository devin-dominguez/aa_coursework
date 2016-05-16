var modules = require('./modules');
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game(player1, player2) {
  this.board = new modules.Board();
  this.player1 = player1;
  this.player2 = player2;
  this.currentPlayer = this.player1;
}

Game.prototype.switchPlayers = function () {
  this.currentPlayer = this.currentPlayer === this.player1 ?
    this.player2 :
    this.player1;
};

Game.prototype.play = function () {
  this.board.display();
  this.takeTurn(this.currentPlayer);
};

Game.prototype.takeTurn = function (player) {
  var board = this.board;
  var game = this;
  player.prompt(function(mark, row, col) {
    var move = board.setMarkAt(mark, row, col);
    if (move) {
      game.switchPlayers();
    } else {
      console.log("Invalid Move, choose again!");
    }
    board.display();

    var winningMark = board.isWon();
    if (winningMark) {
      game.declareWinner(winningMark);
      game.currentPlayer.reader.close();
      return;
    } else if (board.isFull()) {
      game.declareDraw();
      game.currentPlayer.reader.close();
      return;
    }

    game.takeTurn(game.currentPlayer);
  });
};

Game.prototype.declareWinner = function (mark) {
  console.log('The ' + mark + "'s win!");
};

Game.prototype.declareDraw = function () {
  console.log("It's a draw!");
};
var p1 = new modules.Player("Alice", "x", reader);
var p2 = new modules.Player("Bob", "o", reader);

var game = new Game(p1, p2);
game.play();
