dat = require "dat-gui"
page = require "page"


gui = window._gui = new dat.GUI()

options =
	"debug": false
	"index": -> page "/aandl"
	"day": -> page "/aandl/day"
	"digest": -> page "/aandl/digest"
	"night": -> page "/aandl/night"

module.exports = ->
	# debug
	debug = gui.add(options, "debug")

	# navigation
	folder = gui.addFolder("navigation")
	folder.add(options, "index").name("/index")
	folder.add(options, "day").name("/day")
	folder.add(options, "digest").name("/digest")
	folder.add(options, "night").name("/night")
	folder.open()
