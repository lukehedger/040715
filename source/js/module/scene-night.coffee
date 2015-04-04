###
	@module:   scene-night
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-night.styl
	@html:     ./source/template/module/scene-night.html
###


Module = require "./abstract-scene"

AddClass = require "../util/addClass"

module.exports = Module.extend

	template: require "module/scene-night.html"

	oninit: -> @_super()

	onrender: ->
		@on "sendMessage", (e) ->
			@fire "msgSent", @get("message")

			# disable
			@off "sendMessage"
			document.getElementById("message").disabled = true
			AddClass e.node, "disabled"

			# sent!
			link = @find(".postcard__send a")
			link.innerHTML = "Sent"
