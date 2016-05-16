var KeyStore = require('../stores/KeyStore');
var KeyActions = require('../actions/KeyActions');

var ctx = new AudioContext();

function Track(attributes) {
  this.name = attributes.name;
  this.roll = attributes.roll || [];
}

Track.prototype.startRecording = function () {
  this.roll = [];
  this.startTime = ctx.currentTime;
};

Track.prototype.addNotes = function (notes) {
  var noteEvent = {
    timeSlice: ctx.currentTime - this.startTime,
    notes: notes
  };
  this.roll.push(noteEvent);
};

Track.prototype.stopRecording = function () {
  this.addNotes([]);
  KeyActions.saveTrack(this);
};

Track.prototype.play = function () {
  if (this.roll.length === 0) {
    this.stop();
    return;
  }
  KeyActions.startPlaying(this);
  var now = ctx.currentTime;
  var eventQueue = this.roll.slice();
  var currentEvent = eventQueue.shift();
  var that = this;
  this.intervalId = setInterval(function() {
    var elapsedTime = ctx.currentTime - now;
    if (currentEvent.timeSlice <= elapsedTime) {
      KeyActions.removeAllNotes();
      currentEvent.notes.forEach(function (note) {
        KeyActions.addNote(note);
      });
      currentEvent = eventQueue.shift();
      if (!currentEvent) { that.stop(); }
    }

  }, 1);
};

Track.prototype.stop = function () {
  clearInterval(this.intervalId);
  KeyActions.stopPlaying(this);
  KeyActions.removeAllNotes();
};

module.exports = Track;
