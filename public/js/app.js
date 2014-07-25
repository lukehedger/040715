(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(["jquery", "TweenMax", "TimelineMax", "utils/Ajax"], function($, TweenMax, TimelineMax, Ajax) {
    var App;
    return App = (function() {
      App.prototype._code = null;

      App.prototype._guests = null;

      App.prototype._guest = null;

      App.prototype._cardAnimation = null;

      App.prototype._flapAnimation = null;

      function App() {
        this._reset = __bind(this._reset, this);
        this._onCardContainerHover = __bind(this._onCardContainerHover, this);
        this._onGuestsDataSuccess = __bind(this._onGuestsDataSuccess, this);
        var search;
        console.log('040715 up and running...');
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
        $(".addressee h2").html("" + this._guest.name);
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
        this._flapAnimation = new TimelineMax();
        this._flapAnimation.add(TweenMax.to(".envelope", 0.5, {
          y: 100
        }));
        this._flapAnimation.add(TweenMax.to(".card", 0, {
          autoAlpha: 1
        }));
        this._flapAnimation.add(TweenMax.to(".flap", 1, {
          rotationX: 180,
          transformOrigin: "0 0"
        }));
        return setTimeout((function(_this) {
          return function() {
            TweenMax.set(".flap", {
              zIndex: 10
            });
            return _this._showCard();
          };
        })(this), 2000);
      };

      App.prototype._showCard = function() {
        this._cardAnimation = new TimelineMax();
        this._cardAnimation.add(TweenMax.to(".card", 0.5, {
          y: -100,
          height: "+=100"
        }));
        this._cardAnimation.add(TweenMax.to(".card", 0.75, {
          rotation: 25,
          y: -600,
          delay: 0.5
        }));
        this._cardAnimation.add(TweenMax.set(".card", {
          zIndex: 30,
          boxShadow: "0 0 10px #999",
          delay: 0.1
        }));
        this._cardAnimation.add(TweenMax.to(".card", 0.5, {
          y: -200,
          rotation: 0
        }));
        return $("body").on("click", this._reset);
      };

      App.prototype._reset = function() {
        this._cardAnimation.reverse();
        return setTimeout((function(_this) {
          return function() {
            TweenMax.set(".flap", {
              zIndex: 40
            });
            _this._flapAnimation.reverse();
            return setTimeout(function() {
              TweenMax.to(".envelope", 0.85, {
                rotationY: 0
              });
              TweenMax.to(".back", 0, {
                rotationY: 0
              });
              $("body").off("click");
              return $(".card-container").on("mouseover", _this._onCardContainerHover);
            }, 2000);
          };
        })(this), 2000);
      };

      return App;

    })();
  });

}).call(this);

//# sourceMappingURL=maps/app.js.map