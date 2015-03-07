###
	@module:   stage
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/stage.styl
	@html:     ./source/template/module/stage.html
###


Module = require "./abstract-module"
keys = require("mout").object.keys

module.exports = Module.extend

	template: require "module/stage.html"

	data:
		current: 0
		scene: null
		scenes:
			1: "day"
			2: "digest"
			3: "night"

	oninit: ->
		@setScene 1

		window.onkeydown = (e) =>
			@prevScene() if e.keyCode is 38
			@nextScene() if e.keyCode is 40

		@on "*.nextScene", -> @nextScene()
		@on "*.prevScene", -> @prevScene()

	nextScene: ->
		current = @get("current")
		next = if current is keys(@get("scenes")).length then 1 else current+=1
		@setScene next

	prevScene: ->
		current = @get("current")
		prev = if current is 1 then keys(@get("scenes")).length else current-=1
		@setScene prev

	setScene: (scene) ->
		@set
			scene: @get("scenes.#{scene}")
			current: scene
