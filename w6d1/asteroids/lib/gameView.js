(function () {
  if (typeof Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function (ctx, game) {
    this.game = game;
    this.ctx = ctx;
  }

  GameView.prototype.start = function () {
    window.setInterval((function () {
      this.bindKeyHandlers();
      this.game.step();
      this.game.draw(this.ctx);
    }).bind(this), 20);

    window.setInterval((function () {
      if (key.isPressed('space')) this.game.ship.fireBullet();
    }).bind(this), 250);
  }

  GameView.prototype.bindKeyHandlers = function () {
    if (key.isPressed('w')) this.game.ship.power([0, -.5]);
    if (key.isPressed('s')) this.game.ship.power([0, .5]);
    if (key.isPressed('a')) this.game.ship.power([-.5, 0]);
    if (key.isPressed('d')) this.game.ship.power([.5, 0]);
  };
})();
