function Board(){
  this.grid = [new Array(3), new Array(3), new Array(3)];
  for (var i = 0; i < this.grid.length; i++) {
    for (var j = 0; j < this.grid[i].length; j++) {
      this.grid[i][j] = " ";
    }
  }
  this.occupiedSpaces = 0;
}

Board.prototype.render = function () {
  for (var i = 0; i < this.grid.length; i++) {
    if (i !== 0 ) {
      console.log("---------");
    }
    console.log(this.grid[i].join(" | "));
  }
};


Board.prototype.isEmpty = function (pos) {
  return this.grid[pos[0]][pos[1]] === " ";
};

Board.prototype.isValidMove = function (pos) {
  if(pos[0] >= 0 && pos[0] < 3 && pos[1] >= 0 && pos[1] < 3 && this.isEmpty(pos)) {
      return true;
  } else {
    return false;
  }
};

Board.prototype.placePiece = function (pos, piece) {
  if (this.isValidMove(pos)) {
    this.grid[pos[0]][pos[1]] = piece;
    this.occupiedSpaces++;
    return true;
  } else {
    return false;
  }
};

Board.prototype.getWinner = function (piece) {

  for (var i = 0; i < this.grid.length; i++) {
    if (this.grid[i][0] === piece &&
        this.grid[i][1] === piece &&
        this.grid[i][2] === piece) {
            return piece;
        }

    if (this.grid[0][i] === piece &&
        this.grid[1][i] === piece &&
        this.grid[2][i] === piece) {
            return piece;
        }
  }


  if (this.grid[0][0] === piece &&
      this.grid[1][1] === piece &&
      this.grid[2][2] === piece) {
          return piece;
      }


  if (this.grid[0][2] === piece &&
      this.grid[1][1] === piece &&
      this.grid[2][0] === piece) {
          return piece;
      }

  if (this.occupiedSpaces === 9){
    return "draw";
  }

  return null;

};

module.exports = Board;
