class Movie < ApplicationRecord
    has_many(:showings, dependent: :destroy)
end
