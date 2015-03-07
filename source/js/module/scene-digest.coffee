###
	@module:   scene-digest
	@author:   lukehedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/scene-digest.styl
	@html:     ./source/template/module/scene-digest.html
###


Module = require "./abstract-scene"


module.exports = Module.extend

	template: require "module/scene-digest.html"

	# paths:
	# 	default: "M33,0h41c0,0,0,9.871,0,29.871C74,49.871,74,60,74,60H32.666h-0.125H6c0,0,0-10,0-30S6,0,6,0H33"
	# 	right: "M33,0h41c0,0,5,9.871,5,29.871C79,49.871,74,60,74,60H32.666h-0.125H6c0,0,5-10,5-30S6,0,6,0H33"
	# 	left: "M33,0h41c0,0-5,9.871-5,29.871C69,49.871,74,60,74,60H32.666h-0.125H6c0,0-5-10-5-30S6,0,6,0H33"

	oninit: -> @_super()

	onrender: ->
