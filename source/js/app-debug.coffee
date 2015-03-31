dat = require "dat-gui"
page = require "page"


gui = window._gui = new dat.GUI()

options =
	"debug": false
	"index": -> page "/aandl"
	"morning": -> page "/aandl/morning"
	"day": -> page "/aandl/day"
	"night": -> page "/aandl/night"

module.exports = ->
	# debug
	debug = gui.add(options, "debug")

	# navigation
	folder = gui.addFolder("navigation")
	folder.add(options, "index").name("/index")
	folder.add(options, "morning").name("/morning")
	folder.add(options, "day").name("/day")
	folder.add(options, "night").name("/night")
	folder.open()
