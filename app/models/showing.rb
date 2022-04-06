class Showing < ApplicationRecord
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

  def seats()
    return cinema.seats
  end

  def seats_taken()
    
  end

  def self.timeslots(cinema, movie)
    return Timeslot.where.not(id: Showing.select(:timeslot_id).where(cinema_id: cinema.id, movie_id: movie.id).pluck(:timeslot_id))
  end
end
