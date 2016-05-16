var keyMap = require('../constants/KeyMap');
var keyActions = require("../actions/KeyActions");

$( function () {
  $(document).on("keydown", function(e){
    var noteName = keyMap[e.keyCode];
    if (noteName) {
      keyActions.addNote(noteName);
    }
  });

  $(document).on("keyup", function(e){
    var noteName = keyMap[e.keyCode];
    if (noteName) {
      keyActions.removeNote(noteName);
    }
  });
});
