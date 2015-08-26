(function($) {
  $.Zoomable = function (el) {
    this.$el = $(el);
    this.focusBoxSize = 40;
  };

  $.fn.zoomable = function () {
    return this.each(function () {
      new $.Zoomable(this);
    });
  };
}(jQuery));
