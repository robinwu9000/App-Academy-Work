(function () {
  if (typeof Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Util = Asteroids.Util = {};

  Util.inherits = function (child, parent) {
    var Surrogate = function () {};
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate ();
    child.prototype.constructor = child;
  };

  Util.randomVec = function (length) {
    var x = Math.random() * length;
    var y = Math.random() * length;
    return [x, y];
  };

})();
