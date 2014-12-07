class Status < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :user, presence: true

  scope :latest, -> { order(created_at: :desc).first }
end
