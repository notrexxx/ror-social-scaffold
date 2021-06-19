require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'user1', email: 'user1@user1.com', password: '123456') }
  let(:user2) { User.create(name: 'user2', email: 'user2@user2.com', password: '123456') }
  let(:invalid_user) { User.create(name: nil, email: 'user2@user2.com', password: '123456') }
  let(:new_friendship) { Friendship.create(user: user1, friend: user2) }
  let(:new_invalid_friendship) { Friendship.create(user: user1) }
  describe 'Friendships can be created' do
    it 'Sets default value of false to confirmed' do
      expect(new_friendship.confirmed).to be(false)
    end
    it 'Checks if friendship is valid' do
      expect(new_friendship).to be_valid
      expect(user1.friendships.size).to eq(1)
    end
    it 'Checks if friendship is invalid' do
      expect(new_invalid_friendship.valid?).to be(false)
    end
    it 'Checks if user have friends' do
      new_friendship.confirmed = true
      new_friendship.save
      expect(user1.friends.size).to eq(1)
    end
    it 'Checks if user have no friends' do
      new_friendship.save
      expect(user1.friends.size).to eq(0)
    end
    it 'Create 2 rows of friendships' do
      new_friendship.save
      expect(Friendship.all.length).to eq(2)
    end
    it 'Verifies existence of inverse friendship' do
      new_friendship.save
      expect(Friendship.where(user: new_friendship.friend, friend: new_friendship.user)).not_to be_nil
    end
  end

  describe Friendship do
    it 'Should belong to user' do
      t = Friendship.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
