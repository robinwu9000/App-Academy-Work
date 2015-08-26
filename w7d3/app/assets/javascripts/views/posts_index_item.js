JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts_index_item'],

  tagName: 'li',

  events: {
    "click .delete-button" : "deleteItem"
  },

  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  },

  deleteItem: function() {
    this.model.destroy();
    this.remove();
  }
});
