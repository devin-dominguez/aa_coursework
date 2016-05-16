var Dispatcher = require("../dispatcher/Dispatcher");
var Store = require("flux/utils").Store;

var _currentNotes = [];

var keyStore = new Store(Dispatcher);

keyStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case "ADD_NOTE":
      addNote(payload.noteName);
      keyStore.__emitChange();
      console.log(keyStore.allNotes());
      break;
    case "REMOVE_NOTE":
      removeNote(payload.noteName);
      keyStore.__emitChange();
      console.log(keyStore.allNotes());
      break;
    case "REMOVE_ALL_NOTES":
      removeAllNotes();
      keyStore.__emitChange();
      break;

  }
};

function isNotePresent(noteName) {
  return _currentNotes.some(function (note) {
    return note === noteName;
  });
}

function addNote(noteName) {
  if (!isNotePresent(noteName)) {
    _currentNotes.push(noteName);
  }
}

function removeNote(noteName) {
  _currentNotes = _currentNotes.filter(function (note) {
    return note !== noteName;
  });
}

function removeAllNotes () {
  _currentNotes = [];
}

keyStore.allNotes = function() {
  return _currentNotes.slice();
};


module.exports = keyStore;
