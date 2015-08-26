NewsReader.Views.FeedShowItem = Backbone.View.extend({
  template: JST['feed_show_item'],

  render: function () {
    this.$el.html(this.template({entry: this.model}));
    return this;
  }
});
