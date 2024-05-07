class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Check that first_user_must_be admin method before saving the user in the database
  validate :first_user_must_be_admin, on: :create

  # Enum used to save the string into an integer in the database
  enum role: { admin: 0, advertiser: 1, developer: 2 }

  # Mehtod that validates on the server side that the first user signs up as an admin.
  def first_user_must_be_admin
    # The first registered user has to be an admin.
    # If there are no users in the database AND the user is trying to sign up as anything other than admin, an error will be displayed.
    if User.count == 0 && !admin?
      errors.add(:role, 'must be admin for the first user.')

    # Only the first user can be an admin.
    # If there are users in the database AND the user tries to sign up as an admin, an error will be displayed.
    elsif User.count > 0 && admin?
      errors.add(:role, 'cannot be admin. Contact the curent admin for assistance.')
    end
  end

  has_many :advertisements
end
