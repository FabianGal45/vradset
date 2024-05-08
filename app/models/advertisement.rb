class Advertisement < ApplicationRecord
    has_one_attached :file # Active storage - Declares that there is a file to be attached
    belongs_to :user # This line declares that an advertisement belongs to one user
    validates :title, :description, :url, :file, presence: true # Ensures that the following information has been provided
    attr_accessor :check_asai_all, :check_asai_children # This is a virtual attribute that allows the variables to be called upon but not saved in the database
    validates :check_asai_all, acceptance: { message: "- You must comply with all ASAI code of standards" }
    validates :check_asai_children, acceptance: { message: "- You must comply with ASAI code of standards for children" }
end
