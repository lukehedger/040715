Ractive = require "ractive"
Firebase = require "firebase"
page = require "page"

config = require "../config"

module.exports = Ractive.extend

	el: document.body

	append: true

	template: require "main-view.html"

	data:
		view: null
		guest: null

	oninit: () ->
		console.log "[main-view] init"

		@getData()

		@set_router()

	getData: ->
		# TODO - load data/guests to firebase then get db.child("guests").on("value", ...)
		db = new Firebase "https://#{config.firebase}.firebaseio.com/"
		db.on "value", (snapshot) =>
			# TODO - check guest code against guests
			console.log "ok:", snapshot.val()
		, (err) ->
		    console.log "err:", err.code

	set_router: ->
		self = @

		page "/", ->
			console.log "[main-view] index"
			self.set "view": "index"

		page click: false, dispatch: true, hashbang: false
