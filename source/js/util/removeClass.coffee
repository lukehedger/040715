module.exports = (el, className) ->
	if el?
		if el.classList?
			el.classList.remove(className)
		else
			el.className = el.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ')
