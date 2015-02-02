dat = require "dat-gui"
page = require "page"


gui = window._gui = new dat.GUI()

options =
	"debug": false
	"index": -> page "/"
	"test": -> page "/test"

module.exports = ->
	# debug
	debug = gui.add(options, "debug")

	# navigation
	folder = gui.addFolder("navigation")
	folder.add(options, "index").name("/index")
	folder.add(options, "test").name("/test")
	folder.open()
