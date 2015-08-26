Pokedex.Views.ToyDetail = Backbone.View.extend({
  initialize: function (toy) {
    this.toy = toy;

    // this.listenTo(this.toy, 'sync', this.render);
  },

  template: JST['toyDetail'],

  render: function () {
    var content = this.template({toy: this.toy, pokes: []});
    this.$el.html(content);
    return this;
  }
});
