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

	data:
		code: null
		view: null
		content: null
		guest: null
		authorised: false
		loaded: false
		supported: true

	oninit: () ->
		@set_router()

		# catch unsupported
		@set supported: Supported()
		return if !@get("supported")

		# check code
		@observe "code", (newValue) ->
			if newValue?
				# get Firebase data
				@getData newValue

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

		# TODO - change default from "day" to "morning"
		page "/:code/:scene?", (ctx) ->
			self.set
				code: ctx.params.code
				view: if ctx.params.scene? then ctx.params.scene else "day"

		page click: false, dispatch: true, hashbang: false
