class ApplicationController < ActionController::API
  def authenticate_with_token
    hash = JWT.decode(params['admin_token'], Rails.application.secrets.jwt_auth_secret, "HS256")[0] # <= Returns array
    current_user = User.find_by(email: hash['email']).try(:authenticate, hash['password'])

    head :unauthorized unless current_user && hash['exp'] > Time.now.to_i
  end
end
