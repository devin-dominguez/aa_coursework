var FollowToggle = require('./follow_toggle');

function UsersSearch (el) {
  this.$el = $(el);
  this.$input = this.$el.find('.search-input');
  this.$users = this.$el.find('.users');

  // listener on input element
  this.$input.on('input', this.handleInput.bind(this));
}

UsersSearch.prototype.handleInput = function (e) {
  e.preventDefault();
  var ajaxOptions = {
    url: "/users/search",
    type: "GET",
    dataType: "json",
    data: {
      query: this.$input.val()
    },
    success: this.populateUserInfo.bind(this)
  };

  $.ajax(ajaxOptions);
};

UsersSearch.prototype.populateUserInfo = function(users) {
  this.$users.empty();
  var userList = [];
  for (var i = 0; i < users.length; i++) {
    var user = users[i];
    var $li = $("<li>");
    $li.append(
      $("<a>").attr('href','/users/' + user.id).text(user.username)
    );

    var $followButton = $("<button>").addClass("follow-toggle");
    $followButton.data("userId", user.id);
    if(user.followed) {
      $followButton.data("initialFollowState", "followed");
    } else {
      $followButton.data("initialFollowState", "unfollowed");
    }

    new FollowToggle($followButton);

    $li.append($followButton);

    userList.push($li);
  }
  this.$users.append(userList);
};

module.exports = UsersSearch;
