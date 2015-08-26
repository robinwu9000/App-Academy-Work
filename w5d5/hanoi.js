var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame (){
  this.stacks = [ [3,2,1], [], [] ];
}

HanoiGame.prototype.isWon = function () {
  return (this.stacks[1].length === 3 || this.stacks[2].length === 3);
};

HanoiGame.prototype.isValidMove = function (start, end) {
  if (start < 0 || start > 2 || end < 0 || end > 2) {
    return false;
  }
  var startTower = this.stacks[start];
  var endTower = this.stacks[end];
  if(startTower.length > 0 && endTower.length === 0) {
    return true;
  } else if (startTower[startTower.length - 1] < endTower[endTower.length - 1]){
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (start, end) {
  if(this.isValidMove(start, end)){
    var startTower = this.stacks[start];
    var endTower = this.stacks[end];
    endTower.push(startTower.pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Pick start tower: ", function (answer1) {
    reader.question("Pick end tower: ", function (answer2) {
      var start = parseInt(answer1);
      var end = parseInt(answer2);

      callback(start, end);
    });
  });
};

// HanoiGame.prototype.run = function (completionCallback) {
//   var that = this;
//   that.promptMove(function(start, end) {
//     if( that.move(start, end) ) {
//       if( that.isWon() ) {
//         console.log("You won.");
//         completionCallback();
//       } else {
//         that.run(completionCallback);
//       }
//     } else {
//       console.log("That's not a valid move");
//       that.run(completionCallback);
//     }
//   });
// };

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  this.promptMove(function(start, end) {
    if( HanoiGame.prototype.move.bind(that)(start, end) ) {
      if( HanoiGame.prototype.isWon.bind(that)() ) {
        console.log("You won.");
        completionCallback();
      } else {
        that.run(completionCallback);
      }
    } else {
      console.log("That's not a valid move");
      that.run(completionCallback);
    }
  });
};

var test = new HanoiGame();
test.run(function () {
  reader.close();
});
