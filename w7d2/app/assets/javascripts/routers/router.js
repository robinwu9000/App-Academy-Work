Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "" : "pokemonIndex",
    "pokemon/:id" : "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId" : "toyDetail"
  },

  pokemonIndex: function(callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  pokemonDetail : function(id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
      return;
    }

    var poke = this._pokemonIndex.collection.get(id);
    this._pokemonDetail = new Pokedex.Views.PokemonDetail(poke);
    $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
    poke.fetch({
      success: function() {
        callback && callback();
      }
    });
  },

  toyDetail : function(pokemonId, toyId) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
      return;
    }

    var toy = this._pokemonDetail.poke.toys().get(toyId);
    var toyDetailView = new Pokedex.Views.ToyDetail(toy);
    $("#pokedex .toy-detail").html(toyDetailView.$el);
    toyDetailView.render();
  }
});
