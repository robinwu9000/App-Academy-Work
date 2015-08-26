NewsReader.Models.Entry = Backbone.Model.extend({
  // urlRoot: function() {
  //   return this.feed.url + '/entries';
  // },


  initialize: function(data) {

    // this.feed = NewsReader.feeds.getOrFetch(data.feed_id || data.feed.id);
    this.urlRoot =  this.collection.feed.url() + "/entries";
  }
});
