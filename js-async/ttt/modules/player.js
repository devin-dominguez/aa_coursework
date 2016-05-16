var readline = require('readline');

function Player(name, mark, reader) {
  this.name = name;
  this.mark = mark;
  this.reader = reader;
}

Player.prototype.prompt = function (callback) {
  var row = null;
  var col = null;
  var mark = this.mark;
  var that = this;

  this.reader.question(this.name + ' choose a row\n', function(colResponse) {
    row = parseInt(colResponse);

    that.reader.question(that.name + ' choose a col\n', function(rowResponse) {
      col = parseInt(rowResponse);

      callback(mark, row, col);
    });
  });
};

module.exports = Player;
