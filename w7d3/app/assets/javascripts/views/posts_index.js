JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST["posts_index"],
  tagName: "ul",

  initialize: function() {
    this.listenTo(this.collection, "add change remove reset", this.render);
  },

  render: function() {
    var that = this;

    this.$el.html(this.template());

    this.collection.each(function(post) {
      var item = new JournalApp.Views.PostsIndexItem({model: post});
      that.$el.append(item.render().$el);
    });

    return this;
  }
});
