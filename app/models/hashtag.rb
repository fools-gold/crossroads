class Hashtag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_and_belongs_to_many :statuses

  validates :name, presence: true, uniqueness: true
end
