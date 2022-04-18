module Oauth2::Tweet::Errors
  class RequestAccesstokenError < StandardError; end #TODO: add errors to new file
  class NoCodeError < StandardError; end
end