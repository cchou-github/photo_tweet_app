module Api::Tweet::Errors
  class TweetApiError < StandardError; end #TODO: add errors to new file
  class NoAccessTokenError < StandardError; end
end