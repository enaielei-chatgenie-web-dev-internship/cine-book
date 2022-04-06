class Timeslot < ApplicationRecord
    has_many(:showings, dependent: :destroy)

    validates(
        :time,
        presence: true,
        uniqueness: true,
        length: {maximum: 100}
    )

    def pretty_time()
        return self.time.strftime("%-I:%M %p")
    end
end
