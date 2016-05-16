function FollowToggle(el) {
  this.$el = $(el);
  this.userId = this.$el.data('userId');
  this.followState = this.$el.data('initialFollowState');

  this.render();
  this.$el.on("click",this.handleClick.bind(this));
}

FollowToggle.prototype.render = function () {
  if (this.followState === "unfollowing" ||
    this.followState === "following") {
      this.$el.prop("disabled", "true");
    } else {
      this.$el.prop("disabled", "");
    }
  this.$el.html(this.followState);
};

FollowToggle.prototype.toggleFollow = function () {
  this.followState =
    this.followState === "followed" ? "unfollowed" : "followed";
};

FollowToggle.prototype.handleClick = function (e) {
  e.preventDefault();
  this.followState =
    this.followState === "followed" ? "unfollowing" : "following";
  this.render();

  var ajaxOptions = {
    url: "/users/" + this.userId + "/follow",
    dataType: "json",
    success: function(response) {
      this.followState =
        this.followState === "following" ? "followed" : "unfollowed";
      this.render();
    }.bind(this)
  };

  if(this.followState === "unfollowing") {
    ajaxOptions.type = "DELETE";
  } else {
    ajaxOptions.type = "POST";
  }

  $.ajax(ajaxOptions);
};

module.exports = FollowToggle;
