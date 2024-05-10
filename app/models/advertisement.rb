class Advertisement < ApplicationRecord
    has_one_attached :file # Active storage - Declares that there is a file to be attached
    belongs_to :user # This line declares that an advertisement belongs to one user
    validates :title, :description, :url, :file, presence: true # Ensures that the following information has been provided
    attr_accessor :check_asai_all, :check_asai_children # This is a virtual attribute that allows the variables to be called upon but not saved in the database
    validates :check_asai_all, acceptance: { message: "- You must comply with all ASAI code of standards" }
    validates :check_asai_children, acceptance: { message: "- You must comply with ASAI code of standards for children" }

    #Checks that the image type uploaded is being supported by the application (JPEG & PNG)
    validate :correct_image_type

    def correct_image_type
        if file.attached? && !file.content_type.in?(%w(image/jpeg image/png))
            errors.add(:file, 'must be a JPEG, OR PNG')
        end
    end
end
