class Team < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :statuses, through: :users
  has_many :hashtags, -> { uniq }, through: :statuses

  validates :name, presence: true
  validates :description, presence: true, allow_blank: true
end
