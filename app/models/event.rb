class Event < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :attached_events_users
  has_many :attached_users, through: :attached_events_users, source: :user
  has_many :invites
  has_many :documents, -> { order("created_at DESC").limit(3) }
  has_many :comments, -> { order("created_at DESC").limit(3) }
  has_many :notifications
  pg_search_scope :search_everywhere, against: [:time]
  validates :place, presence: true, length: {minimum: 3, maximum: 40}
  validates :description, presence: true, length: {minimum: 5, maximum: 100}

  validates :time,
            date: {after: Proc.new { Time.now },
                   before: Proc.new { Time.now + 1.year }}
  validates :end_time,
            date: {after: :time}


end


