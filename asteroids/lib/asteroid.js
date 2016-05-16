var MovingObject = require("./movingObject");
var Util = require("./util");
var Ship = require("./ship");

function Asteroid(options) {
  options.color = Asteroid.COLOR;
  options.radius = Asteroid.RADIUS;
  options.vel = Util.randomVec(Asteroid.SPEED);
  MovingObject.call(this, options);
}

Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function (otherObject) {
  if(otherObject instanceof Ship) {
    otherObject.relocate();
  }
};


Asteroid.COLOR = 'white';
Asteroid.RADIUS = 10;
Asteroid.SPEED = 1;

module.exports = Asteroid;
