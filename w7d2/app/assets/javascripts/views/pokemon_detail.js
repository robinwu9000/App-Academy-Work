Pokedex.Views.PokemonDetail = Backbone.View.extend({
  initialize: function (poke) {
    this.poke = poke;

    this.listenTo(this.poke, 'sync', this.render);
  },

  template: JST['pokemonDetail'],

  events: {
    "click li" : "selectToyFromList"
  },

  render: function () {
    var content = this.template({pokemon: this.poke});
    this.$el.html(content);

    var $toyList = this.$el.find($('ul.toys'));
    this.poke.toys().each(function (toy) {
      $toyList.append(JST['toyListItem']({ toy: toy }));
    });

    return this;
  },

  selectToyFromList: function(event) {
    var toyId = $(event.currentTarget).data('toy-id');
    // var toy = this.poke.toys().get(toyId);
    // var toyDetailView = new Pokedex.Views.ToyDetail(toy);
    // $("#pokedex .toy-detail").html(toyDetailView.$el);
    // toyDetailView.render();
    var path = "pokemon/" + this.poke.id + "/toys/" + toyId;
    Backbone.history.navigate(path, {trigger: true});
  }

});
