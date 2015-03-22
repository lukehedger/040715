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
		code: null
		guest: null

	oninit: () ->
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
			self.set "view": "day"

		page "/:scene", (ctx) ->
			self.set "view": ctx.params.scene

		page click: false, dispatch: true, hashbang: false
