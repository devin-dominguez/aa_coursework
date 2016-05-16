function TweetCompose ($form, $feed) {
  this.$form = $form;
  this.$feed = $feed;

  this.$form.on('submit',this.submit.bind(this));
}

TweetCompose.prototype.submit = function (e) {
  e.preventDefault();

  var inputs = this.$form.find(":input").serializeJSON();

  var ajaxOptions = {
    url: "/tweets",
    type: "POST",
    dataType: "JSON",
    data: inputs,
    success: this.appendTweet.bind(this)
    // success: function(response) {console.log(response);}
  };

  $.ajax(ajaxOptions);
};

TweetCompose.prototype.appendTweet = function (response) {
  var $li = $('<li>');
  $li.append(response.content + "\n-- ");
  var url = "/users/" + response.user_id;
  var username = response.user.username;
  var $a = $("<a>").attr("href", url).text(username);
  $li.append($a);
  $li.append("\n-- " + response.created_at);
  this.$feed.prepend($li);
};

module.exports = TweetCompose;
