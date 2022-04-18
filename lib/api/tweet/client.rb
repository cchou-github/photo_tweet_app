class Api::Tweet::Client
  include Api::Tweet::Errors
  
  TWEET_ENDPOINT = "/tweets".freeze

  def initialize(access_token:, photo_title:, photo_url:)
    raise NoAccessTokenError if access_token.blank?
    
    @access_token = access_token
    @photo_title  = photo_title
    @photo_url    = photo_url
    @host         = ENV["TWEET_API_HOST"]
  end

  def post_tweet!
    uri = URI(@host  + TWEET_ENDPOINT)
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{@access_token}"
    request.body = JSON.dump({
      "text": @photo_title,
      "url": @photo_url
    })
    client = create_client(uri)
    res = client.request(request) #TODO: Net::ReadTimeout error handling
    
    if res.is_a?(Net::HTTPSuccess)
      true
    else
      raise TweetApiError.new("TweetApiError: code=#{res.code}, message=#{res.message}")
    end
  end

  def create_client(uri)
    client = Net::HTTP.new(uri.host, uri.port)
    client.use_ssl = true
    client
  end
end