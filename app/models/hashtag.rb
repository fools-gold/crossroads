class Hashtag < ActiveRecord::Base
    validates :name, presence: true
    has_and_belongs_to_many :statuses

    scope :latest, -> { order(created_at: :desc).first }
end
