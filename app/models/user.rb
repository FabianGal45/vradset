class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum used to save the string into an integer in the database
  enum role: { admin: 0, advertiser: 1, developer: 2 }

  has_many :advertisements
end
