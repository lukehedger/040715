###
	@module:   scene-digest
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-digest.styl
	@html:     ./source/template/module/scene-digest.html
###


Module = require "./abstract-scene"
keys = require("mout").object.keys

module.exports = Module.extend

	template: require "module/scene-digest.html"

	data:
		current: 1
		x: ["100%", "-200%"]
		slides:
			1:
				title: "slide 1"
				body: "this is slide 1"
				links: ["a","b"]
				active: true
			2:
				title: "slide 2"
				body: "this is slide 2"
				active: false
			3:
				title: "slide 3"
				body: "this is slide 3"
				active: false

	oninit: -> @_super()

	onrender: ->
		# TODO - add swipe controls (ractive)
		@on "goNextSlide", -> @nextSlide()
		@on "goPrevSlide", -> @prevSlide()

	nextSlide: ->
		current = @get("current")
		next = if current is keys(@get("slides")).length then 1 else current+=1
		@set "slides.#{@get("current")}.x", @get("x[1]")
		@set "slides.#{next}.x", @get("x[0]")
		@setSlide next

	prevSlide: ->
		current = @get("current")
		prev = if current is 1 then keys(@get("slides")).length else current-=1
		@set "slides.#{@get("current")}.x", @get("x[0]")
		@set "slides.#{prev}.x", @get("x[1]")
		@setSlide prev

	setSlide: (slide) ->
		@set "slides.#{@get("current")}.active", false
		@set "slides.#{slide}.active", true
		@set current: slide
