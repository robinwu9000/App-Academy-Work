(function() {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function (pos, vel, radius, color, game) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
    this.game = game;
  }

  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI, false);
    ctx.fill();
  }

  MovingObject.prototype.move = function () {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    if (this.game.isOutOfBounds(this.pos)) {
      if (this.isWrappable) {
        this.game.wrap(this.pos);
      } else {
        this.game.remove(this);
      }
    }
  }

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var dist = Math.sqrt(Math.pow(otherObject.pos[0] - this.pos[0], 2) +
                         Math.pow(otherObject.pos[1] - this.pos[1], 2));
    return dist < (this.radius + otherObject.radius);
  }

  MovingObject.prototype.collideWith = function (otherObject) {
    // this.game.remove(this);
    // this.game.remove(otherObject);
  };

  MovingObject.prototype.isWrappable = true;
})();
