require 'rails_helper'
RSpec.describe 'Sign in', type: :system do
  before :each do
    User.create(name: 'user1', email: 'user1@user1.com', password: '123456')
  end

  it 'Signs in' do
    visit '/users/sign_in'

    within('#new_user') do
      fill_in 'Email', with: 'user1@user1.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
