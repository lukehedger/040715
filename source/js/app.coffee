# register all modules
require "./module/index"

# require Ractive plugins
require "ractive-events-tap"

# wait for when the dom is ready and load main view
require("domready") ->
	require("./app-debug")() if process.env.NODE_ENV is "development"

	View = require "./view/main-view"
	window._view = new View()
