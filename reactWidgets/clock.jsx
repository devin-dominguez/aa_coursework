var React = require('react');

var Clock = React.createClass({
  getInitialState: function() {
    var time = new Date();
    return {
      hours: time.getHours(),
      minutes: time.getMinutes(),
      seconds: time.getSeconds()
    };
  },

  tick: function() {
    var seconds = this.state.seconds + 1;
    var minutes = this.state.minutes + Math.floor(seconds / 60);
    var hours = this.state.hours + Math.floor(minutes / 60);

    this.setState({ seconds: seconds % 60, minutes: minutes % 60, hours: hours % 24});

  },

  componentDidMount: function() {
    this.ticking = setInterval(this.tick, 1000);
  },

  componentWillUnmount: function() {
    clearInterval(this.ticking);
  },

  toString: function() {
    var hours = this.state.hours;
    var minutes = this.state.minutes;
    var seconds = this.state.seconds;

    return hours + ":" + minutes + ":" + seconds;
  },

  render: function() {
    return (
      <div>
        {this.toString()}
      </div>
    );
  }

});

module.exports = Clock;
