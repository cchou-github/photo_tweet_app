class Oauth2::Tweet::Client
  include Oauth2::Tweet::Errors

  AUTHORIZE_ENDPOINT = "/authorize".freeze
  TOKEN_ENDPOINT     = "/token".freeze
  REDIRECT_ENDPOINT  = "http://localhost:3000/oauth/callback".freeze

  AUTHORIZE_RESPONSE_TYPE = "code".freeze
  ACCESS_TOKEN_GRANT_TYPE = "authorization_code".freeze

  def initialize(code:)
    raise NoCodeError if code.blank?
    @code = code
    @host = ENV['OAUTH2_TWEET_HOST']
  end

  def self.authorize_url
    ENV['OAUTH2_TWEET_HOST'] + AUTHORIZE_ENDPOINT + "?client_id=#{ENV["OAUTH2_TWEET_CLIENT_ID"]}&response_type=code&redirect_uri=#{REDIRECT_ENDPOINT}"
  end

  def request_access_token!
    uri = URI(@host + TOKEN_ENDPOINT)
    
    params = {
      code: @code,
      client_id: ENV["OAUTH2_TWEET_CLIENT_ID"], 
      client_secret: ENV["OAUTH2_TWEET_CLIENT_SECRET"],
      redirect_uri: REDIRECT_ENDPOINT,
      grant_type: ACCESS_TOKEN_GRANT_TYPE
    }
    uri.query = URI.encode_www_form(params)
    
    request = Net::HTTP::Post.new(uri)
    client = create_client(uri)
    res = client.request(request) #TODO: Net::ReadTimeout error handling
    
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)["access_token"]
    else
      raise RequestAccesstokenError.new("RequestAccesstokenError: code=#{res.code}, message=#{res.message}")
    end
  end

  def create_client(uri)
    client = Net::HTTP.new(uri.host, uri.port)
    client.use_ssl = true
    client
  end
end