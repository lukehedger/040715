define [
	"jquery"
	"TweenMax"
	"TimelineLite"
	"utils/Ajax"
], ($,TweenMax,TimelineLite,Ajax) ->

	class App

		_code : null
		_guests : null
		_guest : null

		_cardAnimation : null
		_flapAnimation : null

		constructor: ->

			search = window.location.search

			if search? and search isnt ""
				@_code = search.match(/\?(.*)/)[1]
				@_getGuestsData()
			else
				# boot off
				console.log "You don't got no code"
				$(".front").html ("Your name's not on the list")

		_getGuestsData: ->

			Ajax.get "../data/guests.json", @_onGuestsDataSuccess, @_onGuestsDataError

		_onGuestsDataSuccess: (data) =>

			@_guests = data.guests

			@_findGuest()

		_onGuestsDataError: (e) ->

			console.log "data error", e

		_findGuest: ->

			@_guest = @_guests.filter((element) =>
				element.code is @_code)[0]

			$(".addressee h2").html ("#{@_guest.name}")

			@_start()

		_start: ->

			@_addListeners()
			@_setupElements()

		_addListeners: ->

			$(".card-container").on "mouseover", @_onCardContainerHover

		_setupElements: ->

			TweenMax.set ".card-container", {perspective:1000}
			TweenMax.set ".tent-canvas", {skewX:"30deg"}

		_onCardContainerHover: (e) =>

			setTimeout =>
				@_openEnvelope()
			,2000

			TweenMax.to ".envelope", 0.85, {rotationY:180}
			TweenMax.to ".back", 0, {rotationY:180}

			$(".card-container").off "mouseover"

		_openEnvelope: ->

			console.log TimelineLite

			@_flapAnimation = new TimelineLite()

			@_flapAnimation.add TweenMax.to(".envelope", 0.5, {y:100})
			.add TweenMax.to(".card", 0, {autoAlpha:1})
			.add TweenMax.to(".flap", 1, {rotationX:180, transformOrigin:"0 0"})
			
			setTimeout =>
				TweenMax.set(".flap", {zIndex:10})
				@_showCard()
			,2000

		_showCard: ->

			@_cardAnimation = new TimelineLite()

			@_cardAnimation.add TweenMax.to(".card", 0.5, {y:-100, height:"+=100"})
			.add TweenMax.to(".card", 0.75, {rotation:25, y:-600, delay: 0.5})
			.add TweenMax.set(".card", {zIndex:30, boxShadow: "0 0 10px #999", delay:0.1})
			.add TweenMax.to(".card", 0.5, {y:-180, rotation:0})
			.add TweenMax.to(".card", 0.5, {scale:1.2})

			# add reset listener
			# $("body").on "click", @_reset

		_reset: =>

			@_cardAnimation.reverse()
			setTimeout =>
				TweenMax.set(".flap", {zIndex:40})
				@_flapAnimation.reverse()

				setTimeout =>
					TweenMax.to ".envelope", 0.85, {rotationY:0}
					TweenMax.to ".back", 0, {rotationY:0}

					# remove reset listener
					$("body").off "click"
					$(".card-container").on "mouseover", @_onCardContainerHover
				,2000
			,2000


