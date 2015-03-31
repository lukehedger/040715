platform = require "platform"

module.exports = () ->

    # IE<9
    return if platform.name is "IE" and parseFloat(platform.version) < 9 then false else true
