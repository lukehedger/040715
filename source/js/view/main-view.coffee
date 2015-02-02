Ractive = require "ractive"
Firebase = require "firebase"
page = require "page"

config = require "../config"

module.exports = Ractive.extend

	el: document.body

	append: true

	template: require "main-view.html"

	data:
		view: "map"
		loggedin: false
		guests: null

	oninit: () ->
		console.log "[main-view] init"

		@getData()

		@set_router()

	getData: ->
		# TODO - load data/guests to firebase then get db.child("guests").on("value", ...)
		db = new Firebase "https://#{config.firebase}.firebaseio.com/"
		db.on "value", (snapshot) =>
			@set "guests", snapshot.val()
			console.log "ok:", @get("guests")
		, (err) ->
		    console.log "err:", err.code

	set_router: ->
		self = @

		page "/", ->
			console.log "[main-view] index"
			self.set "view": "index"

		page "/test", (ctx) ->
			console.log "[main-view] test"
			self.set "view": "test"

		page click: false, dispatch: true, hashbang: false
