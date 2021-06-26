require 'rails_helper'

RSpec.describe Like, type: :model do
  describe Like do
    it 'Should belong to post' do
      t = Like.reflect_on_association(:post)
      expect(t.macro).to eq(:belongs_to)
    end
    it 'Should belong to user' do
      t = Like.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
