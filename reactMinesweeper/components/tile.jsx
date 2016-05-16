var React = require('react');
var classNames = require('classnames');

var Tile = React.createClass({

  tileStatus: function() {
    if(!this.props.tile.explored) {
      return "unexplored";
    } else {
      return "revealed";
    }
  },

  toString: function() {
    if (!this.props.tile.explored) {
      if (this.props.tile.flagged) {
        return "⚐";
      } else {
        return " ";
      }
    } else {
      if(this.props.tile.bombed) {
        return "💣";
          } else  {
        var str = this.props.tile.adjacentBombCount();
        if (str === 0) {
          return " ";
        } else {
          return str;
        }
      }
    }
  },

  handleClick: function(e) {
    e.preventDefault();
    this.props.updateGame(this.props.tile, e.altKey);
  },

  render: function() {
    var classes = classNames('tile', this.tileStatus());
    return (
      <div className={classes} onClick={this.props.tile.explored ? undefined : this.handleClick}>
        {this.toString()}
      </div>
    );
  }

});

module.exports = Tile;
