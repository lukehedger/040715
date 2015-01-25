'use strict'

config = require "./config"

app = angular.module("app", ["firebase"])

app.controller "AppController", ($scope, $firebase) ->
	ref = new Firebase "https://#{config.firebase}.firebaseio.com/"
	# ref = new Firebase "https://#{config.firebase}.firebaseio.com/messages"

	sync = $firebase ref

	$scope.data = sync.$asObject()
	console.log $scope.data
	# $scope.messages = sync.$asArray()

	# TODO - 3-way-binding: https://www.firebase.com/docs/web/libraries/angular/quickstart.html#section-objects
	# TODO - angular structure
