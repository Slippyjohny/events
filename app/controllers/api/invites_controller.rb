class API::InvitesController < API::ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :invite, :through => :event, :shallow => true
  before_action :set_event, only: [:create]


  def create
    @invite = @event.invites.build(invite_params)
    @invite.sender_id = current_user.id

    respond_to do |format|
      if @invite.save
        format.json { render json: @invite.token, status: :ok }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def set_event
    @event=Event.find(params[:event_id])
  end

  def invite_params
    params.permit(:token, :email)
  end
end

