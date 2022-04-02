class Cinema < ApplicationRecord
    has_many(:showings, dependent: :destroy)
end
