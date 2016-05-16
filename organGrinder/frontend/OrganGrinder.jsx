var Dispatcher = require('./dispatcher/Dispatcher');
var Note = require("./util/Note");
var TONES = require("./constants/Tones");
require('./util/KeyListener');
var keyStore = require('./stores/KeyStore');
var React = require('react');
var ReactDom = require('react-dom');
var Key = require('./components/Key');
var Organ = require('./components/Organ');
var TrackStore = require('./stores/TrackStore');

window.Dispatcher = Dispatcher;
window.Note = Note;
window.TONES = TONES;
window.keyStore = keyStore;
window.keyMap = require("./constants/KeyMap");
window.TrackStore = TrackStore;
$( function () {
  ReactDom.render(<Organ/>, $("#content")[0]);
});
