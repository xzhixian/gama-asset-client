// Generated by CoffeeScript 1.7.1
var oauthSign;

oauthSign = require("oauth-sign");

exports.sign = function(method, uri, clientId, clientSecret) {
  var sign, timestamp;
  timestamp = Math.floor(Date.now() / 1000);
  sign = oauthSign.hmacsign(method, uri, timestamp, clientId, clientSecret);
  return {
    timestamp: timestamp,
    signature: sign
  };
};
