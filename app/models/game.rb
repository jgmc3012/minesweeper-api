class Game < ApplicationRecord
  belongs_to :user
  validates :mines_board, :user_board, :user_id, presence: true
  validates :is_over, inclusion: { in: [true, false] }
end
