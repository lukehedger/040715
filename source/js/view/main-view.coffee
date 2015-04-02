Ractive = require "ractive"
Firebase = require "firebase"
page = require "page"

Supported = require "../util/supported"
last = require("mout").array.last
keys = require("mout").object.keys
pad = require("mout").number.pad

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

	db: null

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
		# connect db
		@db = new Firebase "https://#{config.firebase}.firebaseio.com/"

		@db.once "value", (snapshot) =>
			data = snapshot.val()
			@set authorised: if code in keys(data.guests) then true else false
			return if !@get("authorised")
			@onDataSuccess data, code
		, (err) ->
		    console.log "err:", err.code

	onDataSuccess: (data, code) ->
		# set data
		@set
			content: data.content
			guest: data.guests["#{code}"]
			message: if data.messages and data.messages["#{code}"]? then data.messages["#{code}"]["#{last(keys(data.messages["#{code}"]))}"].message else ""
			loaded: true

		# listen for rsvps
		@on "*.msgSent", (msg) ->
			now = new Date()
			ts = "#{now.getFullYear()}#{pad(now.getMonth()+1, 2)}#{pad(now.getDate(), 2)}"
			@db.child("messages/#{@get("code")}").push
				message: msg
				timestamp: ts

	set_router: ->
		self = @

		page "/:code/:scene?", (ctx) ->
			self.set
				code: ctx.params.code
				view: if ctx.params.scene? then ctx.params.scene else "morning"

		page click: false, dispatch: true, hashbang: false
