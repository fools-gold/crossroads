class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :status, counter_cache: true
  belongs_to :hashtag

  belongs_to :likeable, polymorphic: true

  validates :user, presence: true, uniqueness: { scope: :status }
  validates :status, presence: true
end
