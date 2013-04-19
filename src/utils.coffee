module.exports.extend = (destination, source) ->
  Object.extend = (destination, source) ->
    for property of source
      destination[property] = source[property] if source.hasOwnProperty(property)
    destination
  Object.extend destination, source