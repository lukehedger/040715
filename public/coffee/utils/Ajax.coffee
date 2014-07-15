define ["jquery"], ($) ->

	class Ajax

		@get: (url,success,error) ->

			$.ajax
				url: url
				type: "GET"
				dataType: "json"
				success: success
				error: error