###
	@module:   scene-night
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-night.styl
	@html:     ./source/template/module/scene-night.html
###


Module = require "./abstract-scene"


module.exports = Module.extend

	template: require "module/scene-night.html"

	data:
		message: ""

	oninit: -> @_super()

	onrender: ->
		# TODO - 3way binding with firebase? or "SEND" button
		@observe "message", (newValue) ->
			console.log newValue
