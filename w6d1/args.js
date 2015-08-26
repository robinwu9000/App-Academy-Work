var sum = function () {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

Function.prototype.myBind = function (context) {
  var that = this;
  var bindArgs = [].slice.call(arguments, 1);

  return function () {
    var allArgs = bindArgs.concat([].slice.call(arguments));
    that.apply(context, allArgs);
  }
}

function curriedSum (numArgs) {
  var numbers = [];

  var _curriedSum = function (number) {
    numbers.push(number);
    if (numbers.length === numArgs) {
      var sum = 0;
      for (var i = 0; i < numbers.length; i++) {
        sum += numbers[i];
      }

      return sum;
    }
  }

  return _curriedSum;
}


Function.prototype.curry = function(numArgs) {
  var args = [];
  var that = this;

  var _curry = function (arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return that.apply(that, args);
    }
    return _curry;
  }

  return _curry;
}

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

Function.prototype.inherits = function (parent) {
  var Surrogate = function () {};
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};
