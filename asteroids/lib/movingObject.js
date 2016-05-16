function MovingObject (options) {
  this.game = options['game'];
  this.pos = options['pos'];
  this.vel = options['vel'];
  this.radius = options['radius'];
  this.color = options['color'];
  this.remove = false;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.strokeStyle = this.color;
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI, false);
  ctx.closePath();
  ctx.stroke();
};

MovingObject.prototype.move = function () {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
  this.game.wrap(this.pos, this.radius); //TODO smoother wrapping
};

MovingObject.prototype.isCollidedWithOtherObject = function (otherObject) {
  var rad1 = this.radius;
  var rad2 = otherObject.radius;

  var a = rad1 - rad2;
  a *= a;

  var b1 = this.pos[0] - otherObject.pos[0];
  b1 *= b1;

  var b2 = this.pos[1] - otherObject.pos[1];
  b2 *= b2;

  var b = b1 + b2;

  var c = rad1 + rad2;
  c *= c;

  return a <= b && b <= c;
};

MovingObject.prototype.collideWith = function (otherObject) {

};

module.exports = MovingObject;
