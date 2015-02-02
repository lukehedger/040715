###
	@module:   nav
	@author:   Luke Hedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/nav.styl
	@html:     ./source/template/module/nav.html
###


Module = require "./abstract-module"

page = require "page"

module.exports = Module.extend

	template: require "module/nav.html"

	oninit: ->

		@on "toIndex", -> page "/"
		@on "toTest", -> page "/test"
