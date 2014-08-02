(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(["jquery", "TweenMax", "TimelineLite", "utils/Ajax"], function($, TweenMax, TimelineLite, Ajax) {
    var App;
    return App = (function() {
      App.prototype._code = null;

      App.prototype._guests = null;

      App.prototype._guest = null;

      App.prototype._forceStart = null;

      App.prototype._cardAnimation = null;

      App.prototype._flapAnimation = null;

      function App() {
        this._reset = __bind(this._reset, this);
        this._onCardContainerHover = __bind(this._onCardContainerHover, this);
        this._onGuestsDataSuccess = __bind(this._onGuestsDataSuccess, this);
        var matchSearch, search;
        search = window.location.search;
        if ((search != null) && search !== "") {
          matchSearch = search.match(/\?(.*?)\&/) || search.match(/\?(.*)/);
          this._code = matchSearch[1];
          this._getGuestsData();
        } else {
          this._onGuestNotFound();
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
        return this._onGuestNotFound();
      };

      App.prototype._findGuest = function() {
        this._guest = this._guests.filter((function(_this) {
          return function(element) {
            return element.code === _this._code;
          };
        })(this))[0];
        if (this._guest != null) {
          $(".addressee h2").html("" + this._guest.name);
          return this._start();
        } else {
          return this._onGuestNotFound();
        }
      };

      App.prototype._start = function() {
        this._addListeners();
        this._setupElements();
        return this._forceStart = setTimeout((function(_this) {
          return function() {
            return _this._flipEnvelope();
          };
        })(this), 2000);
      };

      App.prototype._addListeners = function() {
        return $(".card-container").on("mouseover", this._onCardContainerHover);
      };

      App.prototype._setupElements = function() {
        TweenMax.set(".card-container", {
          perspective: 1000
        });
        return TweenMax.set(".tent-canvas", {
          skewX: "30deg"
        });
      };

      App.prototype._onGuestNotFound = function() {
        return $(".addressee h2").html("Return to sender");
      };

      App.prototype._onCardContainerHover = function(e) {
        clearTimeout(this._forceStart);
        return this._flipEnvelope();
      };

      App.prototype._flipEnvelope = function() {
        setTimeout((function(_this) {
          return function() {
            return _this._openEnvelope();
          };
        })(this), 1000);
        TweenMax.to(".envelope", 0.85, {
          rotationY: 180
        });
        TweenMax.to(".back", 0, {
          rotationY: 180
        });
        return $(".card-container").off("mouseover");
      };

      App.prototype._openEnvelope = function() {
        this._flapAnimation = new TimelineLite();
        this._flapAnimation.add(TweenMax.to(".envelope", 0.5, {
          y: 100
        })).add(TweenMax.to(".card", 0, {
          autoAlpha: 1
        })).add(TweenMax.to(".flap", 1, {
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
        this._cardAnimation = new TimelineLite();
        return this._cardAnimation.add(TweenMax.to(".card", 0.5, {
          y: -100,
          height: "+=100"
        })).add(TweenMax.to(".card", 0.75, {
          rotation: 25,
          y: -600,
          delay: 0.5
        })).add(TweenMax.set(".card", {
          zIndex: 30,
          boxShadow: "0 0 10px #999",
          delay: 0.1
        })).add(TweenMax.to(".card", 0.5, {
          y: -130,
          rotation: 0
        })).add(TweenMax.to(".card", 0.5, {
          scale: 1.2
        }));
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