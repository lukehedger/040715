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

		constructor: ->

			console.log 'Bayse up and running...'

			search = window.location.search

			if search? and search isnt ""
				@_code = search.match(/\?(.*)/)[1]
				@_getGuestsData()
			else
				console.log "You don't got no code"
				# boot off

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

			$(".card").html ("Hello #{@_guest.name}")

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

			flap = new TimelineMax()

			flap.add TweenMax.to(".envelope", 1, {y:100})
			flap.add TweenMax.to(".card", 0, {autoAlpha:1})
			flap.add TweenMax.to(".flap", 1, {rotationX:180, transformOrigin:"0 0"})
			
			setTimeout =>
				@_showCard()
			,2000

		_showCard: ->

			TweenMax.to ".card", 0.5, {y:-100, height:"+=100"}
			TweenMax.to ".paper", 0.5, {y:400}

