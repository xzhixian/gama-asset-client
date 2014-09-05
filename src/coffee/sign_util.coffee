oauthSign = require "oauth-sign"

exports.sign = (method, uri, clientId, clientSecret) ->
  timestamp = Math.floor(Date.now()/1000)
  sign = oauthSign.hmacsign method, uri, timestamp, clientId, clientSecret
  #console.log "method:#{method} uri:#{uri} timestamp:#{timestamp} clientId:#{clientId} clientSecret:#{clientSecret} sign:#{sign}"
  return {timestamp:timestamp, signature:sign}
