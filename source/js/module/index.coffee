###
	THIS FILE IS GENERATED AUTOMATICALLY AND IT WILL
	BE REPLACED IF A NEW MODULE IS ADDED OR DELETED.
###
Ractive = require "ractive"

register = ->
	Ractive.components["ui-abstract-scene"] = require "./abstract-scene"
	Ractive.components["ui-nav"] = require "./nav"
	Ractive.components["ui-scene-day"] = require "./scene-day"
	Ractive.components["ui-scene-digest"] = require "./scene-digest"
	Ractive.components["ui-scene-night"] = require "./scene-night"
	
	true

module.exports = register()