###
	THIS FILE IS GENERATED AUTOMATICALLY AND IT WILL
	BE REPLACED IF A NEW MODULE IS ADDED OR DELETED.
###
Ractive = require "ractive"

register = ->
	Ractive.components["ui-nav"] = require "./nav"
	Ractive.components["ui-test"] = require "./test"
	
	true

module.exports = register()