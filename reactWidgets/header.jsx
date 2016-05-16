var React = require('react');

var Header = React.createClass({

  render: function() {
    return (
      <li onClick={this.props.onClick}>{this.props.title}</li>
    );
  }

});

module.exports = Header;
