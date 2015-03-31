###
	@module:   scene-day
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-day.styl
	@html:     ./source/template/module/scene-day.html
###


Module = require "./abstract-scene"
keys = require("mout").object.keys
last = require("mout").array.last

module.exports = Module.extend

	template: require "module/scene-day.html"

	partials:
		slideControls: require "partials/slide-controls.html"

	data:
		current: 0
		x: ["100%", "-200%"]

	oninit: -> @_super()

	onteardown: ->
		@prevSlide()
		# TODO - there is a minor issue when moving from digest->day where digest is not visible (behind day) so cannot see outro transition
		@set "slides.*.active", false

	onrender: ->
		@on "goNextSlide", -> @nextSlide()
		@on "goPrevSlide", -> @prevSlide()

		@nextSlide()

	nextSlide: ->
		current = @get("current")
		next = if current is keys(@get("slides")).length then 1 else current+=1
		@set "slides.#{@get("current")}.x", @get("x[1]") if @get("current") isnt 0
		@set "slides.#{next}.x", @get("x[0]")
		@setSlide next

	prevSlide: ->
		current = @get("current")
		prev = if current is 1 then keys(@get("slides")).length else current-=1
		@set "slides.#{@get("current")}.x", @get("x[0]") if @get("current") isnt 0
		@set "slides.#{prev}.x", @get("x[1]")
		@setSlide prev

	setSlide: (slide) ->
		@set "slides.#{@get("current")}.active", false if @get("current") isnt 0
		@set "slides.#{slide}.active", true
		@set current: slide
