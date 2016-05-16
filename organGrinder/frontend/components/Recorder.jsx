var Track = require('../util/Track');
var React = require('react');
var KeyStore = require('../stores/KeyStore');

var Recorder = React.createClass({
  getInitialState: function() {
    this.trackNum = 1;
    return {
      isRecording: false,
      track: new Track({name: "Track" + this.trackNum}),
    };
  },

  componentDidMount: function () {
    KeyStore.addListener(this.recordNotes);
  },

  recordNotes: function () {
    if (this.state.isRecording) {
      this.state.track.addNotes(KeyStore.allNotes());
    }
  },

  clickHandler: function () {
    var isRecording = this.state.isRecording;
    if (isRecording) {
      this.state.track.stopRecording();
      this.setState({track: new Track({name: "Track" + ++this.trackNum})});
    }
    else {
      this.state.track.startRecording();
    }

    this.setState({isRecording: !isRecording});
  },

  render: function() {
    var buttonText = this.state.isRecording ? "stop" : "start";
    var playButtonText = this.state.isPlaying ? "stop track" : "play track";
    return (
      <div>
        <button onClick={this.clickHandler}>{buttonText}</button>
      </div>
    );
  }

});

module.exports = Recorder;
