class Advertisement < ApplicationRecord
    has_one_attached :file # Active storage - Declares that there is a file to be attached
    belongs_to :user # This line declares that an advertisement belongs to one user
end
