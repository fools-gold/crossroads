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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :team_id }
  validates :team, presence: true

  scope :sort_by_contributions, -> {
    joins(:hashtags)
      .select("users.*", "count(users.id) as contributions")
      .group("users.id")
      .order("contributions desc")
  }

  def self.active(date)
    includes(:statuses)
      .where(statuses: { created_at: date.in_time_zone.beginning_of_day.all_day })
      .order("statuses.created_at desc")
  end

  def self.inactive(date)
    active_ids = active(date).ids
    if active_ids.empty?
      order(:first_name)
    else
      where.not(id: active_ids).order(:first_name)
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
