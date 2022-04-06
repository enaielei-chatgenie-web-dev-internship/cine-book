class Movie < ApplicationRecord
    has_many(:showings, dependent: :destroy)
    has_one_attached(:image)

    validates(
        :title,
        presence: true,
        length: {maximum: 150}
    )
    validates(
        :description,
        presence: true,
        length: {maximum: 300}
    )
    validates(:image,
        content_type: {
            in: /\Aimage\/.*\z/,
            message: "must be a valid image format"
        },
            size: {
            less_than: 5.megabytes,
            message: "should be less than 5MB"
        }
    )
end
