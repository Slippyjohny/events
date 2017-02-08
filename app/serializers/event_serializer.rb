class EventSerializer < ActiveModel::Serializer
  attributes :id, :place, :time, :description, :end_time
  has_many :documents
  has_many :comments
end
