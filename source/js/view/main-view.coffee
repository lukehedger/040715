Ractive = require "ractive"
Firebase = require "firebase"
page = require "page"

Supported = require "../util/supported"
keys = require("mout").object.keys

config = require "../config"

module.exports = Ractive.extend

	el: document.body

	append: true

	template: require "main-view.html"

	partials:
		loader: require "partials/loader.html"

	data:
		code: null
		view: null
		content: null
		guest: null
		authorised: true
		loaded: false
		supported: true

	oninit: ->
		@set_router()

		# catch unsupported
		@set supported: Supported()
		return if !@get("supported")

	onrender: ->
		# check code
		code = @get("code")
		if code? then @getData(code) else @set("authorised", false)

	getData: (code) ->
		db = new Firebase "https://#{config.firebase}.firebaseio.com/"
		db.on "value", (snapshot) =>
			data = snapshot.val()
			@set authorised: if code in keys(data.guests) then true else false
			return if !@get("authorised")
			@set
				content: data.content
				guest: data.guests["#{code}"]
				loaded: true
		, (err) ->
		    console.log "err:", err.code

	set_router: ->
		self = @

		page "/:code/:scene?", (ctx) ->
			self.set
				code: ctx.params.code
				view: if ctx.params.scene? then ctx.params.scene else "morning"

		page click: false, dispatch: true, hashbang: false
