class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request , only: [:authenticate]

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      render json: { name: command.result.name ,auth_token: command.result.token}
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def sign_out
    command = current_user.update_attribute(:token, "")
    if command
      render json: { sign_out: command }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end