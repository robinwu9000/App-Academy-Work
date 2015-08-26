Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();

    this.$pokeList.on("click", "li.poke-list-item", this.selectPokemonFromList.bind(this));
    this.$newPoke.on('submit', this.submitPokemonForm.bind(this));
    this.$pokeDetail.on("click", "li.toy-list-item", this.selectToyFromList.bind(this));
    this.$toyDetail.on("change", ".pokemonSelector", this.reassignToy.bind(this));
  },

  addPokemonToList: function(pokemon) {
    var $li = $("<li></li>");
    $li.text(pokemon.get("name") + " " + pokemon.get("poke_type"));
    $li.addClass("poke-list-item");
    $li.attr("data-id", pokemon.id);
    this.$pokeList.append($li);
  },

  refreshPokemon: function() {
    // debugger
    var that = this;
    this.pokemon.fetch({
      success: function() {
        that.pokemon.each(function(pokeman) {
          that.addPokemonToList(pokeman);
        });
      }
    });
  },

  renderPokemonDetail: function(pokemon) {
    var $detail = $("<div></div>");
    $detail.addClass("detail");
    var $img = $("<img src=\"" + pokemon.escape("image_url") + "\">");
    $detail.append($img);

    _(pokemon.attributes).each(function (value, attr) {
      if(attr !== "image_url") {
        $detail.append("<p>" + attr + ": " + value + "</p>");
      }
    });

    this.$pokeDetail.html($detail);
    var $toys = $("<ul></ul>").addClass("toys");
    this.$pokeDetail.append($toys);
    var that = this;
    pokemon.fetch({
      success: function(){
        that.renderToysList(pokemon.toys());
        // pokemon.toys().each(that.addToyToList.bind(that));
        //
        //   function(toy) {
        //   that.addToyToList(toy);
        // });
      }
    });
  },

  selectPokemonFromList: function(event) {
    var $currentTarget = $(event.currentTarget);
    var id = $currentTarget.attr("data-id"); // change to data-id
    var pokeman = this.pokemon.get(id);
    this.$toyDetail.empty();
    this.renderPokemonDetail(pokeman);
  },

  createPokemon: function (attributes, callback) {
    var newPokeman = new Pokedex.Models.Pokemon(attributes);
    var that = this;
    newPokeman.save({}, {
      success: function(){
        that.pokemon.add(newPokeman);
        that.addPokemonToList(newPokeman);
        callback(newPokeman);
      }
    });
  },

  submitPokemonForm: function (event) {
    event.preventDefault();
    var pokemanData = this.$newPoke.serializeJSON().pokemon;
    this.createPokemon(pokemanData, this.renderPokemonDetail.bind(this));
  },

  addToyToList: function(toy) {
    var $li = $("<li></li>").addClass("toy-list-item");
    var name = toy.escape("name");
    var happiness = toy.escape("happiness");
    var price = toy.escape("price");

    $li.attr("data-toy-id", toy.get("id")); // change to data
    $li.attr("data-pokemon-id", toy.get("pokemon_id"));

    $li.
      append("name: " + name + "<br>").
      append("happiness: " + happiness + "<br>").
      append("price: " + price + "<br>");
    this.$pokeDetail.find("ul.toys").append($li);
  },

  renderToyDetail: function(toy) {
    var $toyDetails = $("<div></div>").addClass("detail");
    $toyDetails.attr("data-pokemon-id", toy.get("pokemon_id"));
    $toyDetails.attr("data-toy-id", toy.id);
    var $img = $("<img src=\"" + toy.escape("image_url") + "\">");
    $toyDetails.append($img);
    _(toy.attributes).each(function(value, attr) {
      if(attr !== "image_url") {
        $toyDetails.append("<p>" + attr + ": " + value + "</p>");
      }
    });

    var $pokemonSelector = $("<select></select>").addClass("pokemonSelector");
    this.pokemon.each(function(pokeman) {
      var $option = $("<option></option>").text(pokeman.get("name"));
      $option.attr("value", pokeman.id);
      if (toy.get("pokemon_id") === pokeman.id) {
        $option.prop("selected", true);
      }
      $pokemonSelector.append($option);
    });


    this.$toyDetail.html($toyDetails);
    this.$toyDetail.append($pokemonSelector);
  },

  selectToyFromList: function(event) {
    // debugger
    var currentTarget = $(event.currentTarget);
    var pokeId = currentTarget.attr("data-pokemon-id");
    var toyId = currentTarget.attr("data-toy-id");
    var toy = this.pokemon.get(pokeId).toys().get(toyId);
    this.renderToyDetail(toy);
  },

  reassignToy: function(event) {
    var $delegateTarget = $(event.delegateTarget);
    var $currentTarget = $(event.currentTarget);

    var oldPokemanId = $delegateTarget.find(".detail").data("pokemon-id");
    var oldPokeman = this.pokemon.get(oldPokemanId);

    var toyId = $delegateTarget.find(".detail").data("toy-id");
    var toy = oldPokeman.toys().get(toyId);

    var newPokemanId = $currentTarget.val();
    var that = this;

    toy.set({"pokemon_id": newPokemanId});

    toy.save({}, {success: function () {
      oldPokeman.toys().remove(toyId);
      that.renderToysList(oldPokeman.toys());
      that.$toyDetail.empty();
      }
    });
  },

  renderToysList: function(toys) {
    this.$pokeDetail.find(".toys").empty();
    var that = this;
    toys.each(function(toy){
      that.addToyToList(toy);
    });
  }

});
