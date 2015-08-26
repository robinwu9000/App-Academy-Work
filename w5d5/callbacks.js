function Clock () {
  this.currentTime = null;
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var hrs = this.currentTime.getHours();
  var mins = this.currentTime.getMinutes();
  var secs = this.currentTime.getSeconds();
  console.log(hrs + ":" + mins + ":" + secs);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.currentTime = new Date();
  this.printTime();
  var that = this;
  setInterval(function () {
    that._tick();
  }, Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  var tempTime = this.currentTime;
  this.currentTime.setTime(tempTime.valueOf() + Clock.TICK);
  this.printTime();
};

// var clock = new Clock();
// clock.run();

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  } else {
    reader.question("Enter a number: ", function (input) {
        var num = parseInt(input);
        console.log("Current sum: " + (num + sum));
        addNumbers(num + sum, --numsLeft, completionCallback);
    });
  }
}

// addNumbers(0, 3, function(sum) {
//   console.log("Total: " + sum);
// });

function askIfGreaterThan(el1, el2, callback) {
    reader.question("Is " + el1 + " greater than " + el2 + "?", function(answer) {
        if (answer === "yes") {
          callback(true);
        } else {
          callback(false);
        }
    });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerbubbleSortLoop) {
  if (i < arr.length - 1) {
      askIfGreaterThan(arr[i], arr[i + 1], function (isGreaterThan) {

        if (isGreaterThan){
          var tmp = arr[i];
          arr[i] = arr[i + 1];
          arr[i + 1] = tmp;
          madeAnySwaps = true;
        }

        innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerbubbleSortLoop);
      });
  } else if (i === (arr.length - 1)) {
    outerbubbleSortLoop(madeAnySwaps);
  }
}

function absurdBubbleSort (arr, sortCompletionCallback) {
    function outerbubbleSortLoop (madeAnySwaps) {
      if (madeAnySwaps){
        innerBubbleSortLoop(arr, 0, false, outerbubbleSortLoop);
      } else {
          sortCompletionCallback(arr);
      }
    }

    outerbubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
