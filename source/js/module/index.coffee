###
	THIS FILE IS GENERATED AUTOMATICALLY AND IT WILL
	BE REPLACED IF A NEW MODULE IS ADDED OR DELETED.
###
Ractive = require "ractive"

register = ->
	Ractive.components["ui-abstract-scene"] = require "./abstract-scene"
	Ractive.components["ui-nav"] = require "./nav"
	Ractive.components["ui-scene-morning"] = require "./scene-morning"
	Ractive.components["ui-scene-day"] = require "./scene-day"
	Ractive.components["ui-scene-night"] = require "./scene-night"
	Ractive.components["ui-stage"] = require "./stage"

	true

module.exports = register()
