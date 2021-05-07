module UserHelper
  def invite_link(user)
    return unless current_user != user

    return if current_user.friend?(user)

    if current_user.pending_friends.include?(user)
      'Invite pending'
    else
      link_to('Add Friend?', user_friendships_path(user_id: user.id), method: :post, class: 'profile-link')
    end
  end
  def accept_friendship(friendship)
    show_user = User.find_by(id: params[:id])
    (return unless current_user == show_user)

    link_to('Accept', user_friendship_path(user_id: friendship.id), method: :put, class: 'profile-link')
  end

  def reject_friendship(friendship)
    show_user = User.find_by(id: params[:id])
    (return unless current_user == show_user)

    link_to('Reject', user_friendship_path(user_id: friendship.id), method: :delete, class: 'profile-link')
  end
end
