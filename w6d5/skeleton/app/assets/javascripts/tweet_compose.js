$(function($) {
  $.fn.tweetCompose = function(){
    return this.each(function(){
      new $.TweetCompose(this);
    });
  };

  $.TweetCompose = function(el){
    this.$el = $(el);

    this.$el.on("submit", this.submit.bind(this));
  };
  //  NOT WORKING RIGHT NOWWWWW
  // $.TweetCompose.prototype.submit = function (event) {
  //   event.preventDefault();
  //   this.newTweet =$(".tweet-compose textarea");
  //   this.newMentions = $(".tweet-compose")
  //   $.ajax({
  //
  //   });
  };

}(jQuery));
