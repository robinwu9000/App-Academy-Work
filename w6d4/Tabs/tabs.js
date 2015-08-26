$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr('data-content-tabs'));
  this.$activeTab = this.$contentTabs.find(".active");
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  // Deactivate old tab
  this.$activeTab.addClass("transitioning");
  this.$activeTab.removeClass("active");
  this.$el.find(".active").removeClass("active");
    // debugger;

  // Activate new tab
  var $currentTarget = $(event.currentTarget);
  var $currentTab = $($currentTarget.attr("for"));
  $currentTarget.addClass("active");

  var that = this;
  this.$activeTab.one("transitionend", function(e) {
    that.$activeTab.removeClass("transitioning");
    that.$activeTab = $currentTab;
    that.$activeTab.addClass("active");
    that.$activeTab.addClass("transitioning");
    setTimeout(function () {
      that.$activeTab.removeClass("transitioning");
    }, 0);

  });
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
