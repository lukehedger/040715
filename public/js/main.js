(function() {
  require.config({
    paths: {
      "jquery": "../vendor/jquery",
      "TweenMax": "../vendor/TweenMax.min",
      "TimelineMax": "../vendor/TimelineMax.min"
    },
    shim: {
      app: ["jquery"],
      "TimelineMax": {
        exports: "TimelineMax"
      }
    }
  });

  require(["app"], function(App) {
    return new App();
  });

}).call(this);

//# sourceMappingURL=maps/main.js.map