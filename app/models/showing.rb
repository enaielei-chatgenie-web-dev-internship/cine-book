class Showing < ApplicationRecord
  has_many(:bookings, dependent: :destroy)
  belongs_to(:cinema)
  belongs_to(:movie)
  belongs_to(:timeslot)

  validates(
    :cinema_id,
    presence: true,
  )
  validates(
    :movie_id,
    presence: true,
  )
  validates(
    :timeslot_id,
    presence: true,
  )
  validates(
    :cinema, uniqueness: {
      scope: [:timeslot],
      message: " and Timeslot are existing already"
    }
  )

  def seats()
    return cinema.seats
  end

  def seats_taken()
    return Booking.where(showing_id: id).pluck(:seat)
  end

  def seats_free()
    return ((1..seats).select() {|s| !seats_taken.include?(s)}).to_a
  end

  def seats_layout(cols=5)
    seats = self.seats
    rem = seats.modulo(cols)
    rows = (seats - rem) / cols
    taken = self.seats_taken
    free = self.seats_free
    layout = []
    count = 0

    for i in 1..rows
        layout << []
        for i2 in 1..cols
            count += 1
            layout.last << taken.include?(count)
        end
    end

    if rem > 0
        layout << []
        for i in 1..rem
            count += 1
            layout.last << taken.include?(count)
        end
    end

    return layout
  end
end
