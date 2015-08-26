(function ($) {
  $.Thumbs = function(el) {
    this.$el = $(el);
    this.gutterIdx = 0;
    this.$images = $('.all-images img');
    this.fillGutterImages();
    this.$activeImg = this.$images.eq(0);
    this.activate(this.$activeImg);

    this.$el.on("click", "img", this.clickThumb.bind(this));
    this.$el.on("mouseenter", "img", this.onEnter.bind(this));
    this.$el.on("mouseleave", "img", this.onExit.bind(this));
    this.$el.on("click", ".nav", this.clickNav.bind(this));
  };

  $.Thumbs.prototype.activate = function ($img) {
    $(".active").html($img.clone());
  };

  $.Thumbs.prototype.clickThumb = function (event) {
    var $currentTarget = $(event.currentTarget);
    this.$activeImg = $currentTarget;
    this.activate(this.$activeImg);
  };

  $.Thumbs.prototype.fillGutterImages = function () {
    $('.gutter-images').html(this.$images.slice(this.gutterIdx, this.gutterIdx + 5));
  };

  $.Thumbs.prototype.clickNav = function (event) {
    var $currentTarget = $(event.currentTarget);
    if($currentTarget.attr("class") === "nav left") {
      this.gutterIdx = Math.max(this.gutterIdx - 1, 0);
    } else {
      this.gutterIdx = Math.min(this.gutterIdx + 1, 10);
    }
    this.fillGutterImages();
  };

  $.Thumbs.prototype.onEnter = function (event) {
    var $currentTarget = $(event.currentTarget);
    this.activate($currentTarget);
  };

  $.Thumbs.prototype.onExit = function (event) {
    // var $currentTarget = $(event.currentTarget);
    this.activate(this.$activeImg);
  };


  $.fn.thumbs = function () {
    return this.each(function () {
      new $.Thumbs(this);
    });
  };
}(jQuery));
