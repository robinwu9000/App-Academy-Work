JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "" : "root",
    "posts/new" : "newPostForm",
    "posts/:id" : "postShow",
    "posts/:id/edit" : "editPostForm"
  },

  initialize: function(options) {
    this.$el = options.$el;
    this.$sidebar = this.$el.find(".sidebar");
    this.$content = this.$el.find(".content");
    var index = new JournalApp.Views.PostsIndex({collection: JournalApp.posts});
    this.$sidebar.html(index.render().$el);
  },

  root: function() {
    this.$content.empty();
    this._currentView && this._currentView.remove();
    this._currentView = null;
  },

  postsIndex: function() {
    JournalApp.posts.fetch({reset: true});
    var postsIndexView = new JournalApp.Views.PostsIndex({collection: JournalApp.posts});
    this._swapView(postsIndexView);
  },

  postShow: function(id) {
    var post = JournalApp.posts.getOrFetch(id);
    var postShowView = new JournalApp.Views.PostShow({model: post});
    this._swapView(postShowView);
  },

  editPostForm: function(id) {
    var post = JournalApp.posts.getOrFetch(id);
    var postFormView = new JournalApp.Views.PostForm({model: post, collection: JournalApp.posts});
    this._swapView(postFormView);
  },

  newPostForm: function() {
    var post = new JournalApp.Models.Post();
    var newPostView = new JournalApp.Views.PostForm({model: post, collection: JournalApp.posts});
    this._swapView(newPostView);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$content.html(this._currentView.render().$el);
  }
});
