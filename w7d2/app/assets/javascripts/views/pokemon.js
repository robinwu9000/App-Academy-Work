Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.pokemon-form');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokes = new Pokedex.Collections.Pokemon();

    this.$pokeList.on(
      'click',
      'li.poke-list-item',
      this.selectPokemonFromList.bind(this)
    );
    this.$newPoke.on(
      'submit',
      'form',
      this.submitPokemonForm.bind(this)
    );
    this.$pokeDetail.on(
      'click',
      'li.toy-list-item',
      this.selectToyFromList.bind(this)
    );
  },

  addPokemonToList: function (pokemon) {
    // var $li = $("<li class='poke-list-item'>");
    // $li.data('id', pokemon.escape('id'));
    //
    // $li.html(
    //   "Name: " + pokemon.escape('name') + "<br>" +
    //   "Poke Type: " + pokemon.escape('poke_type')
    // );

    this.$pokeList.append(JST['pokemonListItem']({pokemon:pokemon}));
  },

  refreshPokemon: function () {
    var that = this;

    this.pokes.fetch({ success: function () {
      that.pokes.each(function (poke) {
        that.addPokemonToList(poke);
      });
    }});

    this.$newPoke.html(JST['pokemonForm']());
  },

  renderPokemonDetail: function (pokemon) {
    var that = this;

    // var $detail = $("<div class='detail'>");
    // $detail.html(
    //   "<img src='" + pokemon.escape('image_url') + "'><br>" +
    //   "Name: " + pokemon.escape('name') + "<br>"
    // );
    // for(var attr in pokemon.attributes) {
    //   if(attr != 'id' && attr != 'image_url' && attr != 'name') {
    //     $detail.append("<p>" + attr + ": " + pokemon.escape(attr) + "</p>");
    //   }
    // };

    var content = JST['pokemonDetail']({pokemon:pokemon});

    this.$toyDetail.html('');
    this.$pokeDetail.html(content);
    // this.$pokeDetail.append($("<p>Toys: </p>"));
    // this.$pokeDetail.append($("<ul class='toys'>"));

    pokemon.fetch({ success: function () {
      pokemon.toys().forEach(function (toy) {
        that.addToyToList(toy);
      });
    }});
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data('id');
    var poke = this.pokes.get(id);
    this.renderPokemonDetail(poke);
  },

  createPokemon: function (attributes, callback) {
    var pokemon = new Pokedex.Models.Pokemon(attributes);
    pokemon.save({}, { success: function () {
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback && callback(pokemon);
    }.bind(this)});
  },

  submitPokemonForm: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON();
    this.createPokemon(attributes, this.renderPokemonDetail.bind(this));
  },

  addToyToList: function (toy) {
    // var $li = $("<li class='toy-list-item'>");
    // $li.data('toy-id', toy.escape('id'));
    // $li.data('pokemon-id', toy.escape('pokemon_id'));
    //
    // $li.html(
    //   "Name: " + toy.escape('name') + "<br>" +
    //   "Happiness: " + toy.escape('happiness') + "<br>" +
    //   "Price: " + toy.escape('price')
    // );

    this.$pokeDetail.find($('ul.toys')).append(JST['toyListItem']({toy:toy}));
  },

  renderToyDetail: function (toy) {
    // var $detail = $("<div class='detail'>");
    //
    // $detail.html(
    //   "<img src='" + toy.escape('image_url') + "'>" + "<br>" +
    //   "Name: " + toy.escape('name') + "<br>" +
    //   "Happiness: " + toy.escape('happiness') + "<br>" +
    //   "Price: " + toy.escape('price')
    // );

    var toyDetail = JST['toyDetail']({toy: toy, pokes: this.pokes});

    this.$toyDetail.html(toyDetail);
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data('toy-id');
    var pokemonId = $(event.currentTarget).data('pokemon-id');
    var toy = this.pokes.get(pokemonId).toys().get(toyId);

    this.renderToyDetail(toy);
  }
});
