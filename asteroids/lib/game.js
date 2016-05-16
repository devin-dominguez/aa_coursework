var Asteroid = require("./asteroid");
var Ship = require("./ship");
function Game () {
  this.asteroids = [];
  this.ship = new Ship({game: this});
  this.addAsteroids();
}

Game.prototype.randomPosition = function () {
  var x = Math.random() * Game.DIM_X;
  var y = Math.random() * Game.DIM_Y;
  return [x, y];
};

Game.prototype.addAsteroids = function () {
  for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroid({
      pos: this.randomPosition(),
      game: this
    }));
  }
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0,0, Game.DIM_X, Game.DIM_Y);
  for (var i = 0; i < this.allObjects().length; i++) {
    this.allObjects()[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function () {
  for (var i = 0; i < this.allObjects().length; i++) {
    this.allObjects()[i].move();
  }
};


Game.prototype.wrap = function (pos, radius) {
  radius = 0; //TODO smoother wrapping
  if(pos[0] < -radius){
    pos[0] = Game.DIM_X - pos[0] + radius;
  } else if (pos[0] > Game.DIM_X + radius) {
    pos[0] = pos[0] - Game.DIM_X - radius;
  }

  if(pos[1] < -radius){
    pos[1] = Game.DIM_Y - pos[1] + radius;
  } else if (pos[1] > Game.DIM_Y + radius) {
    pos[1] = pos[1] - Game.DIM_Y - radius;
  }

};

Game.prototype.remove = function (asteroid) {
  asteroid.remove = true;
};

Game.prototype.checkCollisions = function () {
  for (var i = 0; i < this.allObjects().length - 1; i++) {
    for (var j = i+1; j < this.allObjects().length; j++) {

      if (this.allObjects()[i].isCollidedWithOtherObject(this.allObjects()[j])){
        this.allObjects()[i].collideWith(this.allObjects()[j]);
      }
    }
  }
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();

  this.asteroids = this.asteroids.filter(function(asteroid) {
    return !asteroid.remove;
  });
};

Game.prototype.allObjects = function () {
  return this.asteroids.concat(this.ship);
};

Game.DIM_X = 300;
Game.DIM_Y = 300;
Game.NUM_ASTEROIDS = 6;

module.exports = Game;
