NewsReader.Routers.AppRouter = Backbone.Router.extend({
  routes: {
    "" : "feedsIndex",
    "feeds/:id" : "feedShow"
  },


  feedsIndex: function() {
    var view = new NewsReader.Views.FeedsIndex({collection: NewsReader.feeds});
    this._swapView(view);
  },

  feedShow: function (id) {
    var feed = NewsReader.feeds.getOrFetch(id);
    // var view = new NewsReader.Views.FeedShow({model: feed});
    // this._swapView(view);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    $("#content").html(view.render().$el);
  }
});
