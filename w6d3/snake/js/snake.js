(function() {
  var snakeGame = window.snakeGame = (window.snakeGame || {});

  var Snake = snakeGame.Snake = function () {
    this.direction = "E";
    this.segments = [new Coord([20,20]), new Coord([20,21]), new Coord([20,22])]
  }

  Snake.prototype.moveDirection = function (direction) {
    if (direction === "N") {
      return [-1,0];
    }
    if (direction === "E") {
      return [0,1];
    }
    if (direction === "S") {
      return [1,0];
    }
    if (direction === "W") {
      return [0,-1];
    }
  };

  var Coord = snakeGame.Coord = function (coord) {
    this.coord = coord;
  };

  var Board = snakeGame.Board = function () {
    this.snake = new Snake();
    this.grid = new Array(40);
    for (var i = 0; i < this.grid.length; i++) {
      this.grid[i] = new Array(40);
    }
    this.apples = [];
  }

  Snake.prototype.getSegments = function () {
    var segs = [];
    for (var i = 0; i < this.segments.length; i++) {
      segs.push(this.segments[i].coord);
    }
    return segs;
  };

  Board.prototype.render = function () {
    var snakeSegs = this.snake.getSegments();
    console.log(snakeSegs);
    snakeSegs = snakeSegs.map (function(el) { return JSON.stringify(el); });
    for (var i = 0; i < this.grid.length; i++) {
      var str = "";
      for (var j = 0; j < this.grid[i].length; j++) {
        // debugger;
        if(snakeSegs.indexOf(JSON.stringify([i,j])) > -1) {
          str = str + "S";
        } else {
          str = str + "_";
        }
      }
      console.log(str);
      console.log("\n");
    }
  };

  Coord.prototype.plus = function (position) {
    return [this.coord[0] + position[0], this.coord[1] + position[1]];
  };

  Coord.prototype.equals = function (position) {
    return (this.coord[0] === position[0]) && (this.coord[1] === position[1]);
  };

  Coord.prototype.isOpposite = function (position) {
    // [1, 3]   [-1, -3]
  };

  Snake.prototype.move = function () {
    var dir = this.moveDirection(this.direction);
    var last = this.segments.length - 1;
    var newcoord = this.segments[last].plus(dir);
    this.segments.push(new Coord(newcoord));
    delete this.segments[0];
  };

  Snake.prototype.turn = function (dir) {
    var x = this.moveDirection(this.direction);
    var y = this.moveDirection(dir);
    if(x[0] + y[0] === 0 && x[1] + y[1] === 0){
      this.direction;
    } else {
      this.direction = dir;
    }
  };

  // var test = new Board();
  // test.render();

})();
