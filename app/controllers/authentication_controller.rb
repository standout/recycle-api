class AuthenticationController < ApplicationController
  def authenticate
    current_user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if current_user
      token = JWT.encode({email: params[:email], password: params[:password], exp: Time.now.to_i + 86400},
                        Rails.application.secrets.jwt_auth_secret, "HS256")

      render json: { auth_token: token }
    else
      head :unauthorized
    end
  end
end
