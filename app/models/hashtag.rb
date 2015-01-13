class Hashtag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_and_belongs_to_many :statuses
  has_many :contributors, -> { sort_by_contributions }, through: :statuses, source: :user

  validates :name, presence: true, uniqueness: true
end
