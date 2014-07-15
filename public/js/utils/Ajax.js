(function() {
  define(["jquery"], function($) {
    var Ajax;
    return Ajax = (function() {
      function Ajax() {}

      Ajax.get = function(url, success, error) {
        return $.ajax({
          url: url,
          type: "GET",
          dataType: "json",
          success: success,
          error: error
        });
      };

      return Ajax;

    })();
  });

}).call(this);

//# sourceMappingURL=../maps/utils/Ajax.js.map