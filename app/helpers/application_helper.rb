module ApplicationHelper
  # Helper used to shorten the IF function within the views and some controllers.

  #ADMIN
  def user_admin?
    user_signed_in? && current_user.admin?
  end

  # ADVERTISER
  def user_advertiser?
    user_signed_in? && current_user.advertiser?
  end

  def user_advertiser_or_admin?
    user_signed_in? && (current_user.advertiser? || current_user.admin?)
  end

  # DEVELOPER
  def user_developer?
    user_signed_in? && current_user.developer?
  end

  def user_developer_or_admin?
    user_signed_in? && (current_user.developer? || current_user.admin?)
  end

end
