###
	@module:   stage
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/stage.styl
	@html:     ./source/template/module/stage.html
###


Module = require "./abstract-module"
page = require "page"

keys = require("mout").object.keys
forIn = require("mout").object.forIn
AddClass = require "../util/addClass"

module.exports = Module.extend

	template: require "module/stage.html"

	partials:
		stageControls: require "partials/stage-controls.html"
		farm: require "partials/farm.html"

	data:
		current: 0
		scenes:
			1: "day"
			2: "digest"
			3: "night"

	oninit: ->

		window.onkeydown = (e) =>
			@prevScene() if e.keyCode is 38
			@nextScene() if e.keyCode is 40

		@on "goNextScene", -> @nextScene()
		@on "goPrevScene", -> @prevScene()

		@observe "view", (newValue) =>
			if newValue
				forIn(@get("scenes"), (v, k) => return @set current: parseInt(k,10) if v is newValue)

	onrender: ->

		# sun
		line = @find("line")
		# TODO - this dont work!
		# console.log line.getTotalLength()
		# length = line.getTotalLength()
		# TweenMax.to(line, 2, { delay: 1, 'stroke-dashoffset': length, ease:Bounce.easeOut })

		# TODO - flags test
		cable = @find(".cable--left")
		left = @find(".cable--left svg path")
		# len = left.getTotalLength()
		# point = left.getPointAtLength(len)
		div = document.createElement "div"
		AddClass div, "flag"
		# div.style.top = "#{point.y}px"
		# div.style.left = "#{point.x}px"
		cable.appendChild div
		# TODO - dont use svg.path to plot flags - instead get path.width / flag.width = how many flags to add
		# add flags side by side, what about rotation?

	nextScene: ->
		current = @get("current")
		next = if current is keys(@get("scenes")).length then 1 else current+=1
		@setScene next

	prevScene: ->
		current = @get("current")
		prev = if current is 1 then keys(@get("scenes")).length else current-=1
		@setScene prev

	setScene: (scene) ->
		page "/#{@get("scenes.#{scene}")}"
