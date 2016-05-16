var MovingObject = require("./movingObject");
var Util = require("./util");

function Ship (options) {
  options.color = Ship.COLOR;
  options.radius = Ship.RADIUS;
  MovingObject.call(this, options);
  this.relocate();
  this.angle = -Math.PI / 2;
}

Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function () {
  this.pos = this.game.randomPosition();
  this.vel = [0,0];
};

Ship.prototype.power = function (impulse) {
  var dX = Math.cos(this.angle) * impulse;
  var dY = Math.sin(this.angle) * impulse;

  var x = this.vel[0];
  var y = this.vel[1];

  var sumX = x + dX;
  var sumY = y + dY;
  x *= x;
  y *= y;
  sumX *= sumX;
  sumY *= sumY;

  if((x + y) < 25){
    this.vel[0] += dX;
    this.vel[1] += dY;
  } else if ((x + y) > (sumX + sumY)){
    this.vel[0] += dX;
    this.vel[1] += dY;
  }
};

Ship.prototype.draw = function (ctx) {
  var x = this.pos[0];
  var y = this.pos[1];
  var dX = Math.cos(this.angle) * this.radius;
  var dY = Math.sin(this.angle) * this.radius;
  MovingObject.prototype.draw.call(this, ctx);
  ctx.beginPath();
  ctx.moveTo(x, y);
  ctx.lineTo(x + dX, y + dY);
  ctx.stroke();
};

Ship.prototype.turn = function (angle) {
  console.log("TURN");
  this.angle += angle;

};
Ship.RADIUS = 5;
Ship.COLOR = "white";

module.exports = Ship;
