(function () {
  if (typeof Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var RADIUS = 7, COLOR = "green";

  var Bullet = Asteroids.Bullet = function (pos, vel, game) {
    var sign = vel.map(function (el) { return el < 0 ? -1 : 1; });
    var norm = Math.sqrt(Math.pow(vel[0], 2) +
                         Math.pow(vel[1], 2));
    var base = [sign[0] * 3, sign[1] * 3];
    vel = [vel[0] + base[0], vel[1] + base[1]];
    Asteroids.MovingObject.call(this, pos, vel, RADIUS, COLOR, game);
  }
  Asteroids.Util.inherits(Asteroids.Bullet, Asteroids.MovingObject);

  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Asteroid) {
      this.game.remove(otherObject);
      this.game.remove(this);
    }
  };

  Bullet.prototype.isWrappable = false;
})();
