JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST['post_show'],

  events: {
    "click button" : "delete",
    "dblclick .post-title": "editTitle",
    "dblclick .post-body": "editBody",
    "blur .post-title": "updatePost",
    "blur .post-body": "updatePost"
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  },

  delete: function() {
    this.model.destroy();
    Backbone.history.navigate("", {trigger: true});
  },

  editTitle: function(event) {
    var $el = $(event.currentTarget);
    var $input = $("<input>");
    $input.attr("name", "post[title]");
    $input.attr("value", this.model.escape("title"));
    $el.html($input);
  },

  editBody: function(event) {
    var $el = $(event.currentTarget);
    var $textArea = $("<textarea>");
    $textArea.attr("name", "post[body]");
    $textArea.text(this.model.escape("body"));
    $el.html($textArea);
  },

  updatePost: function(event) {
    var that = this;
    var $inputData = $(event.currentTarget).children().eq(0);
    this.model.save($inputData.serializeJSON().post, {
      success: function() {
        that.render();
      },
      error: function(jqXHR, textStatus, errorThrown) {
        var errorMessage = textStatus.responseText;
        $(".error-messages").html(errorMessage);
      },
      wait: true
    });
  }
});
