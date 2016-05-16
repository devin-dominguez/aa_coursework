/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var GameView = __webpack_require__(5);
	var Game = __webpack_require__(4);

	var canvas = document.getElementById("game-canvas");
	var ctx = canvas.getContext("2d");

	var gameView = new GameView(new Game(), ctx);
	gameView.start();


/***/ },
/* 1 */
/***/ function(module, exports) {

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


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	var MovingObject = __webpack_require__(1);
	var Util = __webpack_require__(3);
	var Ship = __webpack_require__(6);

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


/***/ },
/* 3 */
/***/ function(module, exports) {

	
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


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	var Asteroid = __webpack_require__(2);
	var Ship = __webpack_require__(6);
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


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	var Game = __webpack_require__(4);

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


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	var MovingObject = __webpack_require__(1);
	var Util = __webpack_require__(3);

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


/***/ }
/******/ ]);