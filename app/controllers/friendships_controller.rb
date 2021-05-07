class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: 'You invited a friend!'
    else
      redirect_to users_path, alert: 'You cannot invite this friend.'
    end
  end
  def update
    friend = User.find(params[:user_id])
    current_user.confirm_friend(friend)
    redirect_to user_path, notice: "you have added #{friend.name} to your friends list "
  end
  def destroy
    friend = User.find_by(id: params[:user_id])
    current_user.reject_friend(friend)
    redirect_to user_path, notice: "You have rejected #{friend.name}'s Friend Request."
  end
end
