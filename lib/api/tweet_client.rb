class Api::TweetClient
  class TweetApiError < StandardError; end #TODO: add errors to new file
  class NoAccessToken < StandardError; end

  BASE_URL  = "https://arcane-ravine-29792.herokuapp.com/api".freeze
  TWEET_URI = "/tweets".freeze

  def initialize(access_token:, photo_title:, photo_url:)
    raise NoAccessToken if access_token.blank?
    
    @access_token = access_token
    @photo_title  = photo_title
    @photo_url    = photo_url
  end

  def post_tweet!
    url = URI(BASE_URL + TWEET_URI)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{@access_token}"
    request.body = JSON.dump({
      "text": @photo_title,
      "url": @photo_url
    })

    res = https.request(request) #TODO: Net::ReadTimeout error handling
    
    if res.is_a?(Net::HTTPSuccess)
      true
    else
      raise TweetApiError.new("TweetApiError: code=#{res.code}, message=#{res.message}")
    end
  end
end