class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic

  belongs_to :team, counter_cache: true

  has_many :statuses, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :team_id }
  validates :team, presence: true

  scope :active, -> {
    includes(:statuses).order('statuses.created_at desc').references(:statuses).uniq
  }

  def name
    "#{first_name} #{last_name}"
  end
end
