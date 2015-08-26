var ttt = require("./ttt");
var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var tttGame = new ttt.Game(reader);
tttGame.run(function (winMsg) {
  console.log(winMsg);
  reader.close();
});
