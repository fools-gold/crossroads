class Status < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :hashtags

  validates :description, presence: true
  validates :user, presence: true

  scope :latest, -> { order(created_at: :desc).first }
end
