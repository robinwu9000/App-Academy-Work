(function () {
  var Hanoi = window.Hanoi = (window.Hanoi || {});

  var View = Hanoi.View = function View (game, $el) {
    this.game = game;
    this.$el = $el;
    this.clickedPile = false;
    this.setupTowers();
    this.render();
    this.clickTower();
  }

  View.prototype.setupTowers = function () {
    for (var i = 0; i < 3; i++) {
      var $tower = $("<div></div>");
      this.$el.append($tower);
      $tower.addClass("tower");
      for (var j = 0; j < 3; j++) {
        var $cell = $("<div></div>");
        $cell.addClass("cell");
        $(".tower").eq(i).append($cell);
        var $disk = $("<div></div>");
        $cell.append($disk);
        $cell.attr("data", i);
        // var items = ["disk_1", "disk_2", "disk_3"];
        // var item = items[Math.floor(Math.random()*items.length)];
        // $disk.addClass(item)
      }
    }
  };

  View.prototype.render = function () {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        var x = this.game.towers[i][2-j];
        $(".tower").eq(i).children().eq(j).children().removeClass("disk_1 disk_2 disk_3");
        $(".tower").eq(i).children().eq(j).children().addClass("disk_" + x);
      }
    }
  };

  View.prototype.clickTower = function () {
    var $cells = $(".cell");
    var that = this;
    $cells.on("click", function(event) {
      var currentTarget = event.currentTarget;
      var $currentTarget = $(currentTarget);
      console.log(that.clickedPile);
      if(!that.clickedPile) {
        that.clickedPile = $currentTarget.attr("data");
      } else {
        that.game.move(that.clickedPile, $currentTarget.attr("data"));
        that.clickedPile = false;
      }
      that.render();
      if(that.game.isWon()) {
        alert("You won the game.");
      }
    });
  };

})();
