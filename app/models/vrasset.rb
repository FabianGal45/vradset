class Vrasset < ApplicationRecord
    has_one_attached :file # https://edgeguides.rubyonrails.org/active_storage_overview.html#has-one-attached
    has_one_attached :image # This is the image of the asset
end
