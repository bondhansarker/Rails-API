require 'json_web_token'

class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      auth_token = JsonWebToken.encode({user_id: user.id, api_key: ENV["API_KEY"]})
      user.update_columns(token: auth_token)
      user
    else
      errors.add :user_authentication, 'invalid credentials'
      nil
    end
  end

end