JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['post_form'],
  tagName: "form",
  className: "post-form",

  events: {
    "submit" : "submitForm"
  },


  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },


  submitForm : function(event) {
    event.preventDefault();
    var that = this;
    var attributes = $(event.currentTarget).serializeJSON().post;
    this.model.save(attributes, {
      success: function() {
        that.collection.add(that.model);
        Backbone.history.navigate("posts/" + that.model.escape("id"), {trigger: true});
      },
      error: function(jqXHR, textStatus, errorThrown) {
        that.$el.append(textStatus.responseText);
      },
      wait: true
    });
  },

  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  }
});
