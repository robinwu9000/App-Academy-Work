(function($){
  $.fn.usersSearch = function () {
    return this.each( function() {
      new $.UsersSearch(this);
    });
  };

  $.UsersSearch = function(el){
    this.$el = $(el);
    this.$input = $("div.users-search input");
    this.$ul = $("ul.users");
    this.$input.on("input", this.handleInput.bind(this));
  };

  $.UsersSearch.prototype.handleInput = function (event) {
    var inputData = this.$input.serialize();
    var that = this;
    $.ajax({
      url: "/users/search",
      type: "GET",
      dataType: "json",
      data: inputData,
      success: function(data, status, stuff) {
        that.renderResults(data, that.$ul);
      }
    });
  };

  $.UsersSearch.prototype.renderResults = function (data, $ul) {
    $ul.children().remove();
    data.forEach(function(matchingUser){
      var newLi = $("<li></li>");
      var linkToUser = "/users/" + matchingUser.id;
      var newAnchorTag = $("<a></a>").attr("href", linkToUser).text(matchingUser.username);
      newLi.append(newAnchorTag);
      var state = matchingUser.followed ? "followed" : "unfollowed";
      var options = {userId: matchingUser.id, followState: state};
      var newButton = $("<button class='follow-toggle'>");
      newLi.append(newButton);
      newButton.followToggle(options);
      $ul.append(newLi);
    });
  };
}(jQuery));
