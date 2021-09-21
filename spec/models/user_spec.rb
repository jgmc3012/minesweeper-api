require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valdiations model' do
    it 'validations for required field' do
      should validate_presence_of(:username)
    end
  end
end
