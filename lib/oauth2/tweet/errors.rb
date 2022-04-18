module Oauth2::Tweet::Errors
  class RequestAccesstokenError < StandardError; end
  class NoCodeError < StandardError; end
end