function Clock() {
  var date = new Date();
  this.hours = date.getHours();
  this.minutes = date.getMinutes();
  this.seconds = date.getSeconds();
  setInterval(this._tick.bind(this), 1000);
}

Clock.prototype._tick = function () {
  this.seconds += 1;
  if (this.seconds >= 60) {
    this.seconds %= 60;
    this.minutes += 1;
  }

  if (this.minutes >= 60) {
    this.minutes %= 60;
    this.hours += 1;
  }

  this.hours %= 24;

  this.printTime();
};

Clock.prototype.printTime = function () {
  var hours = padTime(this.hours);
  var minutes = padTime(this.minutes);
  var seconds = padTime(this.seconds);

  console.log(hours + ':' + minutes + ':' + seconds);
};

function padTime(time) {
  var stringTime = time.toString();
  if (stringTime.length === 1) {
    stringTime = '0' + stringTime;
  }
  return stringTime;
}

var testClock = new Clock();
