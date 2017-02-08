class API::UsersController < API::ApplicationController
  skip_before_action :authenticate_request

  def create
    @user =User.create(user_params)
    respond_to do |format|
      if @user.save
        format.json { render json: @user }
      else
        format.json { render json: @user.errors }
      end
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end




