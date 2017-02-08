class EmailWorker
  include Sidekiq::Worker
  def perform invite_id, invite_token
    invite=Invite.find(invite_id)
    InviteMailer.new_user_invite(invite, invite_token).deliver
  end
end