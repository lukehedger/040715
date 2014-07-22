define [
	"jquery"
	"TweenMax"
	"TimelineMax"
	"utils/Ajax"
], ($,TweenMax,TimelineMax,Ajax) ->

	class App

		_code : null
		_guests : null
		_guest : null

		_cardAnimation : null
		_flapAnimation : null

		constructor: ->

			console.log '040715 up and running...'

			search = window.location.search

			if search? and search isnt ""
				@_code = search.match(/\?(.*)/)[1]
				@_getGuestsData()
			else
				console.log "You don't got no code"
				# boot off
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

			# $(".card").html ("Hello #{@_guest.name}")

			@_start()

		_start: ->

			@_addListeners()
			@_setupElements()

		_addListeners: ->

			$(".card-container").on "mouseover", @_onCardContainerHover

		_setupElements: ->

			console.log "set"

			TweenMax.set ".card-container", {perspective:1000}

		_onCardContainerHover: (e) =>

			setTimeout =>
				@_openEnvelope()
			,2000

			TweenMax.to ".envelope", 0.85, {rotationY:180}
			TweenMax.to ".back", 0, {rotationY:180}

			$(".card-container").off "mouseover"

		_openEnvelope: ->

			@_flapAnimation = new TimelineMax()

			@_flapAnimation.add TweenMax.to(".envelope", 0.5, {y:100})
			@_flapAnimation.add TweenMax.to(".card", 0, {autoAlpha:1})
			@_flapAnimation.add TweenMax.to(".flap", 1, {rotationX:180, transformOrigin:"0 0"})
			
			setTimeout =>
				TweenMax.set(".flap", {zIndex:10})
				@_showCard()
			,2000

		_showCard: ->

			@_cardAnimation = new TimelineMax()

			@_cardAnimation.add TweenMax.to(".card", 0.5, {y:-100, height:"+=100"})
			@_cardAnimation.add TweenMax.to(".card", 0.75, {rotation:25, y:-600, delay: 0.5})
			@_cardAnimation.add TweenMax.set(".card", {zIndex:30, boxShadow: "0 0 10px #999", delay:0.1})
			@_cardAnimation.add TweenMax.to(".card", 0.5, {y:-150, rotation:0})

			# add reset listener
			$("body").on "click", @_reset

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


