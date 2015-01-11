class Team < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :statuses, through: :users
  has_many :hashtags, through: :statuses

  has_one :integration, dependent: :destroy

  validates :name, presence: true

  def notify(message)
    return unless integration.present?

    client = SlackNotify::Client.new(
      webhook_url: integration.webhook_url,
      username: 'crossroads'
    )

    client.notify(message)
  end
end
