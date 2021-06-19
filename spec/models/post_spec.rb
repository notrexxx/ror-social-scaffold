require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(id: 1, name: 'user1', email: 'user1@user1.com', password: '123456') }
  let(:post) { Post.new(content: 'Content', user_id: 1) }

  describe Post do
    it 'Should have many comments' do
      t = Post.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end
    it 'Should have many likes' do
      t = Post.reflect_on_association(:likes)
      expect(t.macro).to eq(:has_many)
    end
    it 'Should belong user' do
      t = Post.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  it 'Is valid with content length and a user_id(user logged in)' do
    expect(user).to be_valid
  end

  it 'Is not valid without a description' do
    post.content = nil
    expect(post).to_not be_valid
  end
  it 'Creates post' do
    within('#new_user') do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      sleep(3)
      visit root_path
      fill_in 'Content', with: 'Anything'
      click_on 'Save'
      expect(page).to have_content('Post was successfully created.')
    end
  end
end
