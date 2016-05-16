var React = require('react');
var TrackStore = require('../stores/TrackStore');
var KeyAction = require('../actions/KeyActions');

var TrackPlayer = React.createClass({

  getInitialState: function() {
    return {isPlaying: false};
  },

  componentDidMount: function () {
    this.listener = TrackStore.addListener(this.checkPlayBackStatus);
  },

  checkPlayBackStatus: function () {
    this.setState({isPlaying: TrackStore.getPlayBackStatus(this.props.track)});
  },

  playbackHandler: function () {
    var isPlaying = this.state.isPlaying;
    if (isPlaying) {
      this.props.track.stop();
    } else {
      this.props.track.play();
    }
  },

  componentWillUnmount: function() {
    this.listener.remove();
  },

  deleteHandler: function() {
    KeyAction.stopPlaying(this.props.track);
    KeyAction.deleteTrack(this.props.track);
  },

  render: function() {
    var playButtonText = this.state.isPlaying ? "stop track" : "play track";
    return (
      <div> {this.props.track.name}
        <button onClick={this.playbackHandler}>{playButtonText}</button>
        <button onClick={this.deleteHandler}>Delete</button>
      </div>
    );
  }

});

module.exports = TrackPlayer;
