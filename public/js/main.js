(function() {
  require.config({
    paths: {
      "jquery": "../vendor/jquery",
      "TweenMax": "../vendor/TweenMax.min",
      "TimelineLite": "../vendor/TimelineLite"
    },
    shim: {
      app: ["jquery"],
      "TimelineLite": {
        exports: "TimelineLite"
      }
    }
  });

  require(["app"], function(App) {
    return new App();
  });

}).call(this);

//# sourceMappingURL=maps/main.js.map