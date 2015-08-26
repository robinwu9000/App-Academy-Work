(function () {
  if (typeof Asteroids === "undefined" ) {
    window.Asteroids = {};
  }


  var COLOR = "white";
  var RADIUS = 30;

  var Asteroid = Asteroids.Asteroid = function (pos, game) {
    var vel = Asteroids.Util.randomVec(8);
    Asteroids.MovingObject.call(this, pos, vel, RADIUS, COLOR, game);
  }
  Asteroids.Util.inherits(Asteroids.Asteroid, Asteroids.MovingObject);

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  };
})();
