(function () {
  if (typeof Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var DIM_X = 800, DIM_Y = 600, NUM_ASTEROIDS = 4;

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship([DIM_X/2, DIM_Y/2], this);
    this.bullets = [];
    this.allObjects();
  }

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < NUM_ASTEROIDS; i++) {
      this.asteroids.push(new Asteroids.Asteroid(this.randomPosition(), this));
    }
  }

  Game.prototype.randomPosition = function () {
    var x = Math.random() * DIM_X;
    var y = Math.random() * DIM_Y;
    return [x, y];
  }

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0,0,DIM_X, DIM_Y);
    ctx.fillStyle="rgba(0, 0, 0, 0.8)";
    ctx.fillRect(0,0,DIM_X, DIM_Y);

    for (var i = 0; i < this.everything.length; i++) {
      this.everything[i].draw(ctx);
    }
  };

  Game.prototype.moveObjects = function () {
    for (var i = 0; i < this.everything.length; i++) {
      this.everything[i].move();
    }
  };

  Game.prototype.wrap = function (pos) {
    if (pos[0] < 0) {
      pos[0] = DIM_X;
    } else if (pos[0] > DIM_X) {
      pos[0] = 0;
    } else if (pos[1] < 0) {
      pos[1] = DIM_Y;
    } else if (pos[1] > DIM_Y) {
      pos[1] = 0;
    }
  }

  Game.prototype.checkCollisions = function () {
    for (var i = 0; i < this.everything.length - 1; i++) {
     for (var j = i + 1; j < this.everything.length; j++) {
       if(this.everything[i].isCollidedWith(this.everything[j])) {
         this.everything[i].collideWith(this.everything[j]);
       }
     }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (obj) {
    if (obj instanceof Asteroids.Asteroid ) {
      index = this.asteroids.indexOf(obj);
      this.asteroids.splice(index, 1);
    } else {
      index = this.bullets.indexOf(obj);
      this.bullets.splice(index, 1);
    }
    this.allObjects();
  };

  Game.prototype.allObjects = function () {
    this.everything = this.bullets.concat(this.asteroids).concat([this.ship]);
  };

  Game.prototype.add = function (obj) {
    if (obj instanceof Asteroids.Asteroid ) {
      this.asteroids.push(obj);
    } else {
      this.bullets.push(obj);
    }
    this.allObjects();
  };

  Game.prototype.isOutOfBounds = function (pos) {
    return (pos[0] < 0 || pos[0] > DIM_X || pos[1] < 0 || pos[1] > DIM_Y);
  };
})();
