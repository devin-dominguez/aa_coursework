var Dispatcher = require("../dispatcher/Dispatcher");

var keyActions = {
  addNote: function (noteName) {
    Dispatcher.dispatch({
      actionType: "ADD_NOTE",
      noteName: noteName
    });
  },

  removeNote: function (noteName) {
    Dispatcher.dispatch({
      actionType: "REMOVE_NOTE",
      noteName: noteName
    });
  },

  removeAllNotes: function () {
    Dispatcher.dispatch({
      actionType: "REMOVE_ALL_NOTES"
    });
  },

  startPlaying: function (track) {
    Dispatcher.dispatch({
      actionType: "START_PLAYBACK",
      track: track
    });
  },

  stopPlaying: function (track) {
    Dispatcher.dispatch({
      actionType: "STOP_PLAYBACK",
      track: track
    });
  },

  saveTrack: function (track) {
    Dispatcher.dispatch({
      actionType: "ADD_TRACK",
      track: track
    });
  },

  deleteTrack: function (track) {
    Dispatcher.dispatch({
      actionType: "DELETE_TRACK",
      track: track
    });
  }
};

module.exports = keyActions;
