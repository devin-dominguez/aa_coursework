var React = require('react');
var Header = require('./header.jsx');

var Tabs = React.createClass({
  getInitialState: function() {
    return { selectedTab: 0 };
  },

  clicked: function(idx) {
    this.setState({ selectedTab: idx});
  },

  render: function() {
    var self = this;
    return (
      <div>
        <ul>
          {
          this.props.tabs.map(function (tab, idx) {
            //  return <li key={idx} onClick={self.clicked.bind(self, idx)}> {tab.title}</li>;
            return <Header key={idx} title={tab.title} onClick={self.clicked.bind(self, idx)}/>;
          })
          }
        </ul>
        <article>{this.props.tabs[this.state.selectedTab].content}</article>
      </div>
    );
  }
}

);

module.exports = Tabs;
