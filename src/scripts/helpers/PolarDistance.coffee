EARTH_RADIUS_IN_METERS = 6371000

toRadians = (num) ->
  num * Math.PI / 180

module.exports = ([lat1, lon1], [lat2, lon2]) ->
  # got from http://www.movable-type.co.uk/scripts/latlong.html
  φ1 = toRadians lat1
  φ2 = toRadians lat2

  Δφ = toRadians (lat2 - lat1)
  Δλ = toRadians (lon2 - lon1)

  a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) + Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2)

  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  d = EARTH_RADIUS_IN_METERS * c
