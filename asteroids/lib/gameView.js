var Game = require("./game");

function GameView (game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  var game = this.game;
  var ctx = this.ctx;
  
  key('right', game.ship.turn.bind(game.ship, 0.5));
  key('left', game.ship.turn.bind(game.ship, -0.5));
  key('up', game.ship.power.bind(game.ship, 0.25));

  function gameLoop () {
    game.draw(ctx);
    game.step();


    window.requestAnimationFrame(gameLoop);
  }
  window.requestAnimationFrame(gameLoop);
};

module.exports = GameView;
