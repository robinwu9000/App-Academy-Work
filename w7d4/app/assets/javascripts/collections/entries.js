NewsReader.Collections.Entries = Backbone.Collection.extend({
  // url: function() {
  //   return this.feed.url() + "/entries";
  // },

  model: NewsReader.Models.Entry,

  initialize: function(options) {
    this.feed = this.feed || options.feed;
    this.url = this.feed.url() + "/entries";
  }
});
