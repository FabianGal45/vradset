class Vrasset < ApplicationRecord
    has_one_attached :file # https://edgeguides.rubyonrails.org/active_storage_overview.html#has-one-attached
end
