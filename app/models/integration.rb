class Integration < ActiveRecord::Base
  belongs_to :team

  validates :webhook_url, presence: true
  validates :team, presence: true
end
