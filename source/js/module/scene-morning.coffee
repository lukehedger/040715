###
	@module:   scene-morning
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-morning.styl
	@html:     ./source/template/module/scene-morning.html
###


Module = require "./abstract-scene"


module.exports = Module.extend

	template: require "module/scene-morning.html"

	oninit: -> @_super()

	onrender: ->
		
