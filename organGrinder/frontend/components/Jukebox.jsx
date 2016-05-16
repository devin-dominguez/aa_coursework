var React = require('react');
var TrackPlayer = require('./TrackPlayer');
var TrackStore = require('../stores/TrackStore');

var Jukebox = React.createClass({

  getInitialState: function() {
    return {tracks: []};
  },

  getTracks: function() {
    this.setState({tracks: TrackStore.allTracks()});
  },

  componentDidMount: function() {
    TrackStore.addListener(this.getTracks);
  },

  render: function() {
    var tracks = this.state.tracks.map(function (track, idx) {
      return <TrackPlayer track={track} key={idx} />;
    });
    return (
      <div>
        {tracks}
      </div>
    );
  }

});

module.exports = Jukebox;
