class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic

  belongs_to :team, counter_cache: true

  has_many :statuses, dependent: :destroy
  has_many :hashtags, through: :statuses
  has_many :likes, dependent: :destroy
  has_many :favorites, through: :likes, source: :likeable, source_type: "Status"
  has_many :liked_hashtags, through: :likes, source: :likeable, source_type: "Hashtag"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :team_id }
  validates :team, presence: true
  validates :timezone, presence: true, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name).keys }

  scope :sort_by_contributions, -> {
    joins(:hashtags)
      .select("users.*", "count(users.id) as contributions")
      .group("users.id")
      .order("contributions desc")
  }

  before_validation { self.timezone ||= Rails.application.config.time_zone }

  class << self
    def active(period)
      includes(:statuses)
        .where(statuses: { created_at: period })
        .order("statuses.created_at desc")
    end

    def inactive(period)
      active_ids = active(period).ids
      if active_ids.empty?
        order(:first_name)
      else
        where.not(id: active_ids).order(:first_name)
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def like!(status)
    favorites << status unless likes?(status)
  end

  def unlike!(status)
    favorites.destroy(status)
  end

  def likes?(status)
    favorites.include?(status)
  end
end
