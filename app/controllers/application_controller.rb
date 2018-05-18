class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  def authenticate_with_token
    hash = JWT.decode(params['admin_token'], Rails.application.secrets.jwt_auth_secret, "HS256")[0] # <= Returns array
    current_user = User.find_by(email: hash['email']).try(:authenticate, hash['password'])

    head :unauthorized unless current_user && hash['exp'] > Time.now.to_i
  end

  def respond_with(object)
    respond_to do |format|
      format.xml { render xml: object }
      format.json { render json: object }
    end
  end
end
