Function.prototype.myBind = function () {
  var that = arguments[0];
  var boundArgs = [];
  for (var i = 1; i < arguments.length; i++) {
    boundArgs.push(arguments[i]);
  }
  var func = this;
  return function() {
    if (arguments.length > 0) {
      func.apply(that, arguments);
    } else {
      func.apply(that, boundArgs);
    }
  };
};

function flick (times) {
  console.log(this.name + ' ' + times + " flicks " );
}

function Lamp() {
   this.name = "a lamp";
}

var turnOn = function() {
   console.log("Turning on " + this.name);
};

var lamp = new Lamp();

turnOn(); // should not work the way we want it to

var boundTurnOn = turnOn.bind(lamp);
var myBoundTurnOn = turnOn.myBind(lamp);
var boundFlick = flick.myBind(lamp, 5);

boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"
boundFlick();
boundFlick(4);
boundFlick(3);
boundFlick();
