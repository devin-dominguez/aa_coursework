var React = require('react');
var ToyIndexItem = require('./toyIndexItem');

var ToysIndex = React.createClass({

  render: function() {
    var toys = this.props.toys || [];

    var toysIndexItems = toys.map(function (toy, idx) {
      return <ToyIndexItem key={idx} toy={toy}/>;
    });

    return (
      <div>
        {toysIndexItems}
      </div>
    );
  }

});

module.exports = ToysIndex;
