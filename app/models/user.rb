class User < ApplicationRecord
  has_many :games, class_name: 'game', foreign_key: 'reference_id'
  validates :username, presence: true
end
