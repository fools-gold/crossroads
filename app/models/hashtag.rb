class Hashtag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_and_belongs_to_many :statuses
  has_many :contributors, -> { sort_by_contributions }, through: :statuses, source: :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :name, presence: true, uniqueness: true

  def liked_by?(user)
    likers.include?(user)
  end
end
