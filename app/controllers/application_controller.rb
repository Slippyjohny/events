class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  before_action :set_token
  before_action :require_login

  before_action :task_notifications

  def set_token
    @token = params[:invite_token]
  end

  def task_notifications
    if signed_in?
      @notifications = current_user.notifications
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
    flash[:alert] = "You aren't allowed to do that."
  end

end
