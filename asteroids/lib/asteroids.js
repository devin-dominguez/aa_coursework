var GameView = require("./gameView");
var Game = require("./game");

var canvas = document.getElementById("game-canvas");
var ctx = canvas.getContext("2d");

var gameView = new GameView(new Game(), ctx);
gameView.start();
