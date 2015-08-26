(function ($) {
  $.Carousel = function(el) {
    this.$el = $(el);
    this.activeIdx = 0;
    this.transitioning = false;
    $(".items img:first-child").addClass("active");
    this.$el.on("click", "a", this.clickNav.bind(this));
  };

  $.Carousel.prototype.clickNav = function (event) {
    var $currentTarget = $(event.currentTarget);
    if($currentTarget.attr("class") === "slide-right") {
      this.slide(-1);
    } else {
      this.slide(1);
    }
  };

  $.Carousel.prototype.slide = function (dir) {
    if (this.transitioning) {
      return;
    }

    this.transitioning = true;
    var leftRight = dir === 1 ? "left" : "right";
    var opposite = (dir * -1) === 1 ? "left" : "right"
    var $imgs = $(".items img");
    var currentIndex = this.activeIdx;
    var nextIndex = (this.activeIdx + dir) % $imgs.length;
    var that = this;

    $imgs.eq(nextIndex).addClass("active").addClass(leftRight);
    $imgs.eq(currentIndex).addClass(opposite);
    $imgs.eq(currentIndex).one("transitionend", function () {
      $imgs.eq(currentIndex).removeClass("active").removeClass(opposite);
      that.transitioning = false;
    });

    setTimeout(function () {
      $imgs.eq(nextIndex).removeClass(leftRight);
    }, 0);

    this.activeIdx = nextIndex;
  };

  $.fn.carousel = function() {
    return this.each(function() {
      new $.Carousel(this);
    });
  };
}(jQuery));
