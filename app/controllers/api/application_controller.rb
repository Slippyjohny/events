class API::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  before_action :set_token

  attr_reader :current_user
  private
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: {error: 'Not Authorized'}, status: 401 unless @current_user
  end

  def set_token
    if request.headers['Invite'].present?
      puts @token=request.headers['Invite'].split(' ').last
      invite = Invite.find_by_token(@token)
      if invite !=nil
        invite.recipient_id=current_user.id
        AttachedEventsUser.create(user_id: current_user.id, event_id: invite.event.id)
        invite.save
      end
    end
  end


  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: exception.message.to_json }

    end
  end
end