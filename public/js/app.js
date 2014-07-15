(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(["jquery", "TweenMax", "TimelineMax", "utils/Ajax"], function($, TweenMax, TimelineMax, Ajax) {
    var App;
    return App = (function() {
      App.prototype._code = null;

      App.prototype._guests = null;

      App.prototype._guest = null;

      function App() {
        this._onCardContainerHover = __bind(this._onCardContainerHover, this);
        this._onGuestsDataSuccess = __bind(this._onGuestsDataSuccess, this);
        var search;
        console.log('Bayse up and running...');
        search = window.location.search;
        if ((search != null) && search !== "") {
          this._code = search.match(/\?(.*)/)[1];
          this._getGuestsData();
        } else {
          console.log("You don't got no code");
          $(".front").html("Your name's not on the list");
        }
      }

      App.prototype._getGuestsData = function() {
        return Ajax.get("../data/guests.json", this._onGuestsDataSuccess, this._onGuestsDataError);
      };

      App.prototype._onGuestsDataSuccess = function(data) {
        this._guests = data.guests;
        return this._findGuest();
      };

      App.prototype._onGuestsDataError = function(e) {
        return console.log("data error", e);
      };

      App.prototype._findGuest = function() {
        this._guest = this._guests.filter((function(_this) {
          return function(element) {
            return element.code === _this._code;
          };
        })(this))[0];
        $(".card").html("Hello " + this._guest.name);
        return this._start();
      };

      App.prototype._start = function() {
        this._addListeners();
        return this._setupElements();
      };

      App.prototype._addListeners = function() {
        return $(".card-container").on("mouseover", this._onCardContainerHover);
      };

      App.prototype._setupElements = function() {
        console.log("set");
        return TweenMax.set(".card-container", {
          perspective: 1000
        });
      };

      App.prototype._onCardContainerHover = function(e) {
        setTimeout((function(_this) {
          return function() {
            return _this._openEnvelope();
          };
        })(this), 2000);
        TweenMax.to(".envelope", 0.85, {
          rotationY: 180
        });
        TweenMax.to(".back", 0, {
          rotationY: 180
        });
        return $(".card-container").off("mouseover");
      };

      App.prototype._openEnvelope = function() {
        var flap;
        flap = new TimelineMax();
        flap.add(TweenMax.to(".envelope", 1, {
          y: 100
        }));
        flap.add(TweenMax.to(".card", 0, {
          autoAlpha: 1
        }));
        flap.add(TweenMax.to(".flap", 1, {
          rotationX: 180,
          transformOrigin: "0 0"
        }));
        return setTimeout((function(_this) {
          return function() {
            return _this._showCard();
          };
        })(this), 2000);
      };

      App.prototype._showCard = function() {
        TweenMax.to(".card", 0.5, {
          y: -100,
          height: "+=100"
        });
        return TweenMax.to(".paper", 0.5, {
          y: 400
        });
      };

      return App;

    })();
  });

}).call(this);

//# sourceMappingURL=maps/app.js.map