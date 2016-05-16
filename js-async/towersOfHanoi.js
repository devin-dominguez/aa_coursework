var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame () {
  this.stacks = [[3, 2, 1], [], []];
}

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  var start = null;
  var end = null;
  reader.question("Starting stack?", function (startResponse) {
    start = parseInt(startResponse);

    reader.question("Ending stack?", function (endResponse) {
      end = parseInt(endResponse);

      callback(start, end);
    });
  });
};

Array.prototype.last = function() {
  return this[this.length - 1];
};
Array.prototype.isEmpty = function() {
  return this.length === 0;
};
Array.prototype.eq = function(array) {
  if (this.length !== array.length) {
    return false;
  }

  for (var i = 0; i < this.length; i++) {
    if (this[i] !== array[i]) {
      return false;
    }
  }
  return true;
};

HanoiGame.prototype.isValidMove = function (start, end) {
  if (this.stacks[start].isEmpty()) {
    return false;
  } else {
    return this.stacks[end].isEmpty() ||
      (this.stacks[end].last() > this.stacks[start].last());
  }
};

HanoiGame.prototype.move = function (start, end) {
  if (this.isValidMove(start, end)) {
    this.stacks[end].push(this.stacks[start].pop());
    return true;
  }
  return false;
};

HanoiGame.prototype.print = function () {
  for (var i = 0; i < this.stacks.length; i++) {
    console.log(i + ":" + JSON.stringify(this.stacks[i]));
  }
};

HanoiGame.prototype.isWon = function () {
  if (this.stacks[1].eq([3, 2, 1]) || this.stacks[2].eq([3, 2, 1])) {
    return true;
  }
  return false;
};

HanoiGame.prototype.run = function (completionCallBack) {
  var that = this;
  this.promptMove(function (start, end) {
    if (!that.move(start, end)) {
      console.log("Invalid Move");
    }
    if (that.isWon()) {
      console.log("You Won!");
      completionCallBack();
    } else {
      that.run(completionCallBack);
    }
  });
};

var hanoi = new HanoiGame();
hanoi.run(function () {
  reader.close();
});
// console.log(hanoi.isWon());
// hanoi.stacks = [[1, 2], [], [3]];
// console.log(hanoi.isWon());
// hanoi.stacks = [[], [], [3, 2, 1]];
// console.log(hanoi.isWon());
// hanoi.stacks = [[], [3, 2, 1], []];
// console.log(hanoi.isWon());

// hanoi.stacks = [[1, 2], [], [3]];
// console.log(hanoi.isValidMove(2, 0));
// console.log(hanoi.isValidMove(2, 1));
// console.log(hanoi.isValidMove(0, 2));
// console.log(hanoi.isValidMove(1, 0));

//
// function dummyCallback (start, end) {
//   console.log(start + " " + end);
// }
//
// hanoi.promptMove(dummyCallback);
