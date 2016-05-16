var TONES = {};

var baseFreq = 16.35;
var noteNames = ['c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b'];

(function () {
  for (var i = 0; i < 128; i++ ) {
    var Note = noteNames[i % 12] + Math.floor(i / 12);
    var freq = baseFreq * Math.pow(2, i / 12);
    TONES[Note.toUpperCase()] = freq;
  }
})();

module.exports = TONES;
