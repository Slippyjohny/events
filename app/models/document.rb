class Document < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  belongs_to :event
  belongs_to :user

  validates :attachment, presence: true
  validates :name, presence: true
end
