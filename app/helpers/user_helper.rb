module UserHelper
  def current_user_or_friend?(user)
    current_user == user || current_user.friend?(user)
  end

  def invite_link(user)
    return 'Friend' if current_user.friend?(user)
    return if current_user_or_friend?(user)

    if user.pending_friendship?(current_user)
      'Invite pending'
    else
      unless current_user.pending_friendship?(user)

        link_to('Add Friend?', user_friendships_path(user_id: user.id), method: :post, class: 'profile-link')
      end
    end
  end

  def accept_friendship_with_user(user)
    return if current_user_or_friend?(user)
    return unless current_user.pending_friendship?(user)

    friendship = current_user.pending_friendship(user)

    link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'profile-link')
  end

  def reject_friendship_with_user(user)
    return if current_user_or_friend?(user)
    return unless current_user.pending_friendship?(user)

    friendship = current_user.pending_friendship(user)

    link_to('Reject', user_friendship_path(friendship.user, friendship.id), method: :delete, class: 'profile-link')
  end

  def accept_friendship(friendship)
    return unless current_user == @user

    link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'profile-link')
  end

  def reject_friendship(friendship)
    return unless current_user == @user

    link_to('Reject', user_friendship_path(friendship.user, friendship.id), method: :delete, class: 'profile-link')
  end
end
