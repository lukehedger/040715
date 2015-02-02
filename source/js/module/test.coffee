###
	@module:   test
	@author:   Luke Hedger <luke.hedger@gmail.com>
	@css:      ./source/css/module/test.styl
	@html:     ./source/template/module/test.html
###


Module = require "./abstract-module"


module.exports = Module.extend

	template: require "module/test.html"

	oninit: ->
		console.log "test :)"

