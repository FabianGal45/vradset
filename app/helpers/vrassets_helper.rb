module VrassetsHelper
  # Helper used to shorten the IF function within the views.
  def user_developer?
    user_signed_in? && current_user.developer?
  end
end
