module VrassetsHelper
  # Helper used to shorten the IF function within the views.
  def user_developer?
    user_signed_in? && current_user.developer?
  end

  def user_developer_or_admin?
    user_signed_in? && (current_user.developer? || current_user.admin?)
  end

  def user_admin?
    user_signed_in? && current_user.admin?
  end

end
