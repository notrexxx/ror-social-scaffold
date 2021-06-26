require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create(name: 'user1', email: 'user1@user1.com', password: '123456') }
  let(:user2) { User.create(name: 'user2', email: 'user2@user2.com', password: '123456') }
  let(:invalid_user) { User.create(name: nil, email: 'user@email.com', password: '123456') }

  describe 'A user can be created' do
    it 'User is valid' do
      expect(user1).to be_valid
    end

    it 'User is invalid' do
      expect(invalid_user).to_not be_valid
    end
  end
  describe User do
    it 'Should have many comments' do
      t = User.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end
    it 'Should have many likes' do
      t = User.reflect_on_association(:likes)
      expect(t.macro).to eq(:has_many)
    end
    it 'Should have many posts' do
      t = User.reflect_on_association(:posts)
      expect(t.macro).to eq(:has_many)
    end
    it 'Should have many Friends' do
      t = User.reflect_on_association(:friendships)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe 'Friendship request created' do
    it 'User can add friend requests' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      expect(user1.pending_friends.size).to eq(1)
    end

    it 'User can accept friend requests' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      user2.confirm_friend(user1)
      friends = user1.friend?(user2)
      expect(friends).to eq(true)
    end

    it 'User can reject friend requests' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      user2.reject_friend(user1)
      friends = user1.friend?(user2)
      expect(friends).to eq(false)
    end
  end
end
