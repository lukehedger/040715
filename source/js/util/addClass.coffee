module.exports = (el, className) ->
	if el?
		if el.classList?
			el.classList.add(className)
		else
			el.className += ' ' + className
