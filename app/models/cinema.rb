class Cinema < ApplicationRecord
    has_many(:showings, dependent: :destroy)
    has_one_attached(:image)

    validates(
        :name,
        presence: true,
        length: {maximum: 100}
    )
    validates(
        :location,
        presence: true,
        length: {maximum: 100}
    )
    validates(
        :seats,
        presence: true,
        comparison: {greater_than: 0}
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

    def bookings()
        return Booking.joins(:showing).where("showings.cinema_id = ?", id)
    end
end
