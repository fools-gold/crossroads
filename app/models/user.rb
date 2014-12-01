class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  belongs_to :team

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :team_id }
  validates :team, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
