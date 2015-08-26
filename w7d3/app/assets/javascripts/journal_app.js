window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    JournalApp.posts = new JournalApp.Collections.Posts();
    JournalApp.posts.fetch();
    JournalApp.router = new JournalApp.Routers.PostsRouter({$el: $(".root")});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
