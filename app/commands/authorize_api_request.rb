require 'json_web_token'

class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    if signature_checked && decoded_auth_token
      @user ||= User.find_by(token: http_auth_header)
    end
  rescue => e
  end

  def signature_checked
    decoded_auth_token[:api_key] == ENV["API_KEY"]
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end