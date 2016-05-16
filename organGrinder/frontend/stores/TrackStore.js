var Dispatcher = require("../dispatcher/Dispatcher");
var Store = require('flux/utils').Store;

var _tracks = [];
var _isPlaying = {};

var TrackStore = new Store(Dispatcher);

TrackStore.__onDispatch = function(payload) {
  switch (payload.actionType) {
    case "ADD_TRACK":
      addTrack(payload.track);
      TrackStore.__emitChange();
      break;
    case "START_PLAYBACK":
      addPlaying(payload.track);
      TrackStore.__emitChange();
      break;
    case "STOP_PLAYBACK":
      removePlaying(payload.track);
      TrackStore.__emitChange();
      break;
    case "DELETE_TRACK":
      deleteTrack(payload.track);
      TrackStore.__emitChange();
      break;
  }
};


TrackStore.getPlayBackStatus = function (track) {
  return _isPlaying[track.name];
};

function deleteTrack (track) {
  var idx = _tracks.findIndex(function (trk) {
    return trk.name === track.name;
  });
  _tracks.splice(idx, 1);
}

function addPlaying (track) {
  _isPlaying[track.name] = true;
}

function removePlaying (track) {
  _isPlaying[track.name] = false;
}

function addTrack (track) {
  _tracks.push(track);
}

TrackStore.allTracks = function() {
  return _tracks.slice();
};

module.exports = TrackStore;
