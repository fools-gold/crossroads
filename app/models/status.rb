class Status < ActiveRecord::Base
  include Routing

  belongs_to :user
  has_and_belongs_to_many :hashtags

  delegate :team, to: :user

  validates :description, presence: true
  validates :user, presence: true

  scope :latest, -> { order(created_at: :desc).first }

  after_save :update_hashtags

  after_commit :notify_team

  def update_hashtags
    self.hashtags = extract_hashtags.map { |name| Hashtag.find_or_create_by(name: name) }
  end

  def extract_hashtags
    names = description.scan(/(?<=#)[[:alpha:]][[[:alnum:]]-]*/).uniq
    names.each { |name| yield name } if block_given?
    names
  end

  def notify_team
    team.notify "<#{user_url(user)}|#{user.name}> is <#{users_url}|working on> #{description}"
  end
end
