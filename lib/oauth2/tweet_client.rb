class Oauth2::TweetClient
  class RequestAccesstokenError < StandardError; end #TODO: add errors to new file
  class NoCodeError < StandardError; end

  BASE_URL      = "https://arcane-ravine-29792.herokuapp.com/oauth".freeze
  AUTHORIZE_URI = "/authorize".freeze
  TOKEN_URI     = "/token".freeze
  REDIRECT_URI  = "http://localhost:3000/oauth/callback".freeze

  AUTHORIZE_RESPONSE_TYPE = "code".freeze
  ACCESS_TOKEN_GRANT_TYPE = "authorization_code".freeze

  def initialize(code:)
    raise NoCodeError if code.blank?
    @code = code
  end

  def self.authorize_url
    BASE_URL + AUTHORIZE_URI + "?client_id=#{ENV["OAUTH2_TWEET_CLIENT_ID"]}&response_type=code&redirect_uri=#{REDIRECT_URI}"
  end

  def request_access_token!
    uri = URI(BASE_URL + TOKEN_URI)
    res = Net::HTTP.post_form(
      uri, 
      code: @code,
      client_id: ENV["OAUTH2_TWEET_CLIENT_ID"], 
      client_secret: ENV["OAUTH2_TWEET_CLIENT_SECRET"],
      redirect_uri: REDIRECT_URI,
      grant_type: ACCESS_TOKEN_GRANT_TYPE
    )

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)["access_token"]
    else
      raise RequestAccesstokenError.new("#{e.class}: code=#{res.code}, message=#{res.message}")
    end
  end
end