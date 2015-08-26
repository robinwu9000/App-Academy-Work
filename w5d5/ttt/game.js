var Board = require("./board.js");

function Game(reader) {
  this.reader = reader;
  this.board = new Board();
  this.players = ["X", "O"];
  this.currentIdx = 0;
}

Game.prototype.run = function (completionCallback) {
  var game = this;
  var current = game.players[game.currentIdx];

  game.prompt(current, function (pos) {
    if (game.board.placePiece(pos, current)){
      var winner = game.board.getWinner(current);
      if (winner === current){
        game.board.render();
        completionCallback("Player " + current + " wins!");
      } else if (winner === "draw") {
        game.board.render();
        completionCallback("Draw game!");
      } else {
        game.switchPlayer();
        game.run(completionCallback);
      }
    } else {
      game.run(completionCallback);
    }
  });
};

Game.prototype.prompt = function (current, callback) {
  this.board.render();
  this.reader.question("Player " + current + " turn:", function(input) {
    var pos = input.split(/\D/);
    pos = pos.map(function (el) { return parseInt(el); } );

    callback(pos);
  });
};

Game.prototype.switchPlayer = function () {
  this.currentIdx = (this.currentIdx === 1) ? 0 : 1;
};

module.exports = Game;
