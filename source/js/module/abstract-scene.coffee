###
	@module:   abstract-scene
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/abstract-scene.styl
	@html:     ./source/template/module/abstract-scene.html
###


Module = require "./abstract-module"

module.exports = Module.extend

	template: require "module/abstract-scene.html"

	oninit: ->
		
