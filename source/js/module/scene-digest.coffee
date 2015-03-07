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
		current: 0
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

	oninit: -> @_super()

	onrender: ->
		# TODO - slide data from firebase

		@setSlide 1

		# @observe "active", (newValue) ->
		# 	if newValue
		# 		console.log "scene 2 active!"

		# DEBUG
		# window.onkeydown = (e) =>
		# 	return if !@get("active")
		# 	@prevSlide() if e.keyCode is 37
		# 	@nextSlide() if e.keyCode is 39

		setTimeout =>
			@nextSlide()
		, 4000
		setTimeout =>
			@prevSlide()
		, 8000

	nextSlide: ->
		current = @get("current")
		next = if current is keys(@get("slides")).length then 1 else current+=1
		@setSlide next

	prevSlide: ->
		current = @get("current")
		prev = if current is 1 then keys(@get("slides")).length else current-=1
		@setSlide prev

	setSlide: (slide) ->
		# TODO - need to clear currently active slide
		@set "slides.#{slide}.active", true
		@set current: slide
