(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var game = this.game;
    var that = this;
    $(".cell").on("click", function(event){
      var currentTarget = event.currentTarget;
      var $currentTarget = $(currentTarget);
    // debugger;
      var pos = $currentTarget.attr('data-pos').split(',');
      pos = pos.map(function(el) { return parseInt(el)});
      try {
        game.playMove(pos);

      } catch(error) {
        alert("Invalid move");
      }
      that.makeMove($currentTarget);
    });
  };

  View.prototype.makeMove = function ($square) {
    $square.text(this.game.currentPlayer);
    $square.addClass("clicked");
    $square.addClass(this.game.currentPlayer);
    if(this.game.isOver()) {
      alert("Somebody won");
    }
  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 3; i++) {
      var $row = $("<div></div>");
      $row.addClass("row");
      $row.attr("data-row", i);
      this.el.append($row);
      for (var j = 0; j < 3; j++) {
        var $cell = $("<div>Hello</div>");
        $cell.addClass("cell");
        $(".row").eq(i).append($cell);
        $cell.attr("data-pos", [$cell.parent().attr('data-row'), j]);
      }
    }
  };
})();
