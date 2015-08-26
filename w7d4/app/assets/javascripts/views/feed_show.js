NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST['feed_show'],

  initialize: function () {
    // this.entries = this.model.entries();

    this.listenTo(this.model.entries(), "update", this.render);
  },

  render: function () {
    $(".feed-items").empty();

    this.model.entries().each(function(entry) {
      this.addEntry(entry);
    }.bind(this));

    var content = this.template({feed: this.model});
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addEntry: function (entry) {
    var view = new NewsReader.Views.FeedShowItem({model: entry});
    this.addSubview(".feed-items", view);
  }


//   initialize: function () {
//     this.entries = this.model.entries();
//     // this.entries.each(function(entry) {
//     //   this.addEntry(entry);
//     // }.bind(this));
//
//     this.listenTo(this.model, "sync", this.refresh);
//     this.listenTo(this.entries, "remove", this.removeEntry);
//     // this.listenTo(this.entries, "sync", this.syncSubviews);
//   },
//
//   events: {
//     "click button.refresh-button" : "refresh"
//   },
//
//   addEntry: function (entry) {
//     var view = new NewsReader.Views.FeedShowItem({model: entry});
//     this.addSubview(".feed-items", view);
//   },
//
//   addEntries: function() {
//     this.entries.each(function(entry) {
//       this.addEntry(entry);
//     }.bind(this));
//     this.render();
//   },
//
//   removeEntry: function(model) {
//     // alert("removing" + model.get("title"))
//     this.removeModelSubview(".feed-items", model);
//   },
//
//   render: function () {
//     var content = this.template({feed: this.model});
//     this.$el.html(content);
//     this.attachSubviews();
//     return this;
//   },
//
//   fetchEntries: function() {
//     this.entries.fetch();
//   },
//
//   refresh: function() {
//     this.entries.fetch({
//       success: this.addEntries.bind(this)
//     });
//   }
//
//
//   // initialize: function() {
//   // },
//   //
//
//   //
//   // render: function() {
//   //   this.$el.html(this.template({feed: this.model, entries: this.model.entries()}));
//   //   return this;
//   // },
//   //
});
