class API::UsersController < API::ApplicationController
respond_to :json

  def show
    render json: current_user.as_json(except: [:password_digest, :encrypted_password, :confirmation_token,:remember_token, :token])
  end

end




