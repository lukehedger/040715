###
	@module:   scene-day
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-day.styl
	@html:     ./source/template/module/scene-day.html
###


Module = require "./abstract-scene"


module.exports = Module.extend

	template: require "module/scene-day.html"

	oninit: -> @_super()

	onrender: ->
		path = @find("path")
		length = path.getTotalLength()
		TweenMax.to(path, 2, { delay: 1, 'stroke-dashoffset': length, ease:Bounce.easeOut })
