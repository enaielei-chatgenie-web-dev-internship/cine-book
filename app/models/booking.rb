class Booking < ApplicationRecord
  belongs_to(:showing)
  belongs_to(:user)

  validates(
      :showing_id,
      presence: true
  )
  validates(
      :user_id,
      presence: true
  )
  validates(
      :seat,
      presence: true,
      comparison: {greater_than: 0}
  )
  validates(
    :showing, uniqueness: {
      scope: [:seat],
      message: "and Seat are existing already"
    }
  )
end
