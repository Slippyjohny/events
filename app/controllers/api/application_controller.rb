class API::ApplicationController < ActionController::Base
  before_action :current_user
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  before_action :set_token

  attr_reader :current_user
  private
  def current_user
    @current_user ||= User.first
  end

  def set_token
    if request.headers['Invite'].present?
      token=request.headers['Invite'].split(' ').last
      @invite = Invite.find_by_token(token)

    elsif params[:invite_token].present?
      token = params[:invite_token]
      @invite = Invite.find_by_token(token)
    end

    if @invite !=nil
      @invite.recipient_id=current_user.id
      AttachedEventsUser.create(user_id: current_user.id, event_id: @invite.event.id)
      @invite.save

    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message.to_json
  end
end