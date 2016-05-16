
var Util = {};
 Util.inherits = function(subClass, superClass) {
  function Surrogate () {}
  Surrogate.prototype = superClass.prototype;
  subClass.prototype = new Surrogate();
  subClass.prototype.constructor = subClass;
};

Util.randomVec = function(speed) {
  var direction = Math.random() * Math.PI * 2;
  var x = Math.cos(direction) * speed;
  var y = Math.sin(direction) * speed;

  return [x, y];
};

module.exports = Util;
