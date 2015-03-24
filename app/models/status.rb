class Status < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :hashtags, touch: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: ["image/jpeg", "image/gif", "image/png"]

  validates :description, presence: true
  validates :user, presence: true

  scope :latest, -> { order(created_at: :desc).first }
  scope :today, -> { where(created_at: Time.zone.today.beginning_of_day.all_day) }
  scope :yesterday, -> { where(created_at: Time.zone.yesterday.beginning_of_day.all_day) }

  after_save :update_hashtags

  class << self
    def during(period)
      where(created_at: period)
    end
  end

  def update_hashtags
    self.hashtags = extract_hashtags.map { |name| Hashtag.find_or_create_by(name: name) }
  end

  def extract_hashtags
    names = description.scan(/(?<=#)[[:alpha:]][[[:alnum:]]-]*/).uniq
    names.each { |name| yield name } if block_given?
    names
  end

  def liked_by?(user)
    likers.include?(user)
  end
end
