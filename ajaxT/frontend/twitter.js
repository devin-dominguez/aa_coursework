var FollowToggle = require('./follow_toggle');
var UsersSearch = require('./users_search');
var TweetCompose = require('./tweet_compose');

$(function () {
  var $navs = $('.users-search');
  new UsersSearch($navs[0]);

  var $followButtons = $("button.follow-toggle");
  $followButtons.each(function (_i, el) {
    new FollowToggle(el);
  });

  var $tweetForm = $('.tweet-compose');
  var $tweetFeed = $('#feed');
  new TweetCompose($tweetForm, $tweetFeed);

});
