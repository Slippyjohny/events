class User < ApplicationRecord
  include Clearance::User
  has_many :events
  has_many :attached_events_users
  has_many :attached_events, through: :attached_events_users, source: :event
  has_many :invitations, class_name: 'Invite', :foreign_key => 'recipient_id'
  has_many :sent_invites, class_name: 'Invite', :foreign_key => 'sender_id'
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :attached_user_id
  has_many :documents
  before_save :encrypted_password
  has_secure_password

  def encrypted_password
    self.encrypted_password=password_digest
  end


end
