require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'valdiations model' do
      it 'validations for required field' do
        should validate_presence_of(:user_id)
        should validate_presence_of(:mines_board)
        should validate_presence_of(:user_board)
        should validate_inclusion_of(:is_over).in_array([true, false])
    end
  end
end
