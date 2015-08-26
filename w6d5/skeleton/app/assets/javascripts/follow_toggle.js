(function($) {
  $.FollowToggle = function (el, options) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id") || options.userId;
    this.followState = this.$el.data("follow-state") || options.followState;
    this.render();
    this.$el.on("click", this.handleClick.bind(this));
  };

  $.FollowToggle.prototype.render = function () {
    // debugger;
    if(this.followState === "unfollowed") {
      this.$el.text("Follow!");
    } else if(this.followState === "followed") {
      this.$el.text("Unfollow!");
    } else {
      this.$el.prop("disabled", true);
    }
  };

  $.FollowToggle.prototype.handleClick = function (event) {
    event.preventDefault();
    var requestType = (this.followState === "unfollowed" ? "POST" : "DELETE");
    var newState = (this.followState === "unfollowed" ? "followed" : "unfollowed");
    var that = this;
    this.followState = "changing";
    this.render();
    $.ajax({
      url: "/users/" + this.userId + "/follow",
      dataType: "json",
      type: requestType,
      success: function(data, statusText, jqXHR){
        $("button.follow-toggle").attr("data-follow-state", newState);
        that.followState = newState;
        that.$el.prop("disabled", false);
        that.render();
      },
      error: function(){
        alert("you can't do that");
      }
    });
  };

  $.fn.followToggle = function (options) {
    return this.each(function () {
      new $.FollowToggle(this, options);
    });
  };


}(jQuery));
