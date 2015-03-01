###
	@module:   scene-day
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-day.styl
	@html:     ./source/template/module/scene-day.html
###


Module = require "./abstract-scene"


module.exports = Module.extend

	template: require "module/scene-day.html"

	oninit: ->
		console.log "scene-day :)"

