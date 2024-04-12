module ApplicationHelper
  # Helper used to shorten the IF function within the views.
  def user_advertiser?
    user_signed_in? && current_user.advertiser?
  end
end
