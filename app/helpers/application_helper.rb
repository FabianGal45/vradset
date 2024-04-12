module ApplicationHelper
  def user_advertiser?
    user_signed_in? && current_user.advertiser?
  end
end
