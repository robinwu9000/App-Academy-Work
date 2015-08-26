(function () {
  if (typeof Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var RADIUS = 20, COLOR = "blue";

  var Ship = Asteroids.Ship = function (pos, game) {
    var vel = [0, 0];
    Asteroids.MovingObject.call(this, pos, vel, RADIUS, COLOR, game);
  }
  Asteroids.Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
    this.vel = [0,0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.fireBullet = function () {
    var posBull = [this.pos[0], this.pos[1]];
    var velBull = [this.vel[0], this.vel[1]];
    this.game.add(new Asteroids.Bullet(posBull, velBull, this.game));
  };
})();
