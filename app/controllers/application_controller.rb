class ApplicationController < ActionController::API
  def authenticate_with_token
    hash = params.permit!.to_h

    begin
      email = hash['email']
      token = hash['admin_token']
      user_secret = Admin.find_by(email: email).secret

      decoded_token = JWT.decode(token, user_secret, 'H256')
    rescue
      raise "Unauthorized"
    end
  end
end
