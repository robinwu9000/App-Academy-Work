JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "api/posts",
  model: JournalApp.Models.Post,

  getOrFetch: function(id) {
    var post = this.get(id);
    if(!post) {
      post = new JournalApp.Models.Post({id: id});
      this.add(post);
    }

    post.fetch();
    return post;
  }
});
