Pokedex.Views.PokemonIndex = Backbone.View.extend({
  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();

    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPokemonToList);
  },

  events: {
    "click li" : "selectPokemonFromList"
  },

  render: function () {
    this.$el.empty();

    var that = this;
    this.collection.each(function(poke){
      that.addPokemonToList(poke);
    });
  },

  addPokemonToList: function(pokemon) {
    this.$el.append(JST['pokemonListItem']({pokemon:pokemon}));
  },

  refreshPokemon: function(callback) {
    this.collection.fetch({
      success: function () {
        if (callback) { callback(); }
      }
    });
  },

  selectPokemonFromList: function(event) {
    var id = $(event.currentTarget).data('id');
    // var poke = this.collection.get(id);
    // var pokeDetailView = new Pokedex.Views.PokemonDetail(poke);
    // $("#pokedex .pokemon-detail").html(pokeDetailView.$el);
    // poke.fetch();
    Backbone.history.navigate("pokemon/" + id, {trigger: true});
  }

});
