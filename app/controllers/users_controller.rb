class UsersController < Clearance::UsersController


  def create
    super
    if @token != nil
      invite = Invite.find_by_token(@token)
      if invite !=nil
        invite.recipient_id=current_user.id
        AttachedEventsUser.create(user_id: current_user.id, event_id: invite.event.id)
        invite.save
      end
    end
  end


  private
  def user_params
    params[:user].permit(:email, :password, :invite_token)
  end
end