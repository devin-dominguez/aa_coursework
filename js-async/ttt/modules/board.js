var _ = require("underscore");

function Board(){
  this.grid = [];
  this.populate();
}

Board.prototype.populate = function() {
  for (var row = 0; row < 3; row++) {
    this.grid[row] = [];
    for (var col = 0; col < 3; col++) {
      this.grid[row][col] = ' ';
    }
  }
};

Board.prototype.display = function() {
  for (var row = 0; row < 3; row++) {
    console.log(this.grid[row].join("|"));
    if (row !== 2) {
      console.log("-----");
    }
  }
};

Board.prototype.setMarkAt = function (mark, row, col) {
  if (this.isValidMove(row, col)) {
    this.grid[row][col] = mark;
    return true;
  }
  return false;
};

Board.prototype.isValidMove = function (row, col) {
  if (!(_.contains([0,1,2], row) && _.contains([0,1,2], col))) {
    return false;
  }
  return this.grid[row][col] === ' ';
};

Board.prototype.getRow = function (rowNum) {
  return this.grid[rowNum].slice();
};

Board.prototype.getCol = function (colNum) {
  var col = [];
  for (var i = 0; i < this.grid.length; i++) {
    col.push(this.grid[i][colNum]);
  }
  return col;
};

Board.prototype.getDiagonal = function (direction) {
  var diag = [];
  if (direction === "left") {
    diag.push(this.grid[0][0]);
    diag.push(this.grid[1][1]);
    diag.push(this.grid[2][2]);
  }
  else {
    diag.push(this.grid[0][2]);
    diag.push(this.grid[1][1]);
    diag.push(this.grid[2][0]);
  }

  return diag;
};

Board.prototype.isWinningLine = function(line) {
  if (_.contains(line, ' ')) {
    return false;
  }
  var modelEl = line[0];
  if (modelEl === line[1] && modelEl === line[2]) {
    return modelEl;
  }
  return false;
};

Board.prototype.isWon = function () {
  for (var i = 0; i < 3; i++) {
    if (this.isWinningLine(this.getRow(i))) {
      return this.isWinningLine(this.getRow(i));
    }

    if (this.isWinningLine(this.getCol(i))) {
      return this.isWinningLine(this.getCol(i));
    }
  }

  if (this.isWinningLine(this.getDiagonal('left'))) {
    return this.isWinningLine(this.getDiagonal('left'));
  }

  if (this.isWinningLine(this.getDiagonal('right'))) {
    return this.isWinningLine(this.getDiagonal('right'));
  }
  return false;
};

Board.prototype.isFull = function () {
  return !_.chain(this.grid).flatten().contains(' ').value();
};

module.exports = Board;
