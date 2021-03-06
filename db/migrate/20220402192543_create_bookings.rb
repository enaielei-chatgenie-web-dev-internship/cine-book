class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table(:bookings) do |t|
      t.references(:showing, null: false, foreign_key: true)
      t.belongs_to(:user, foreign_key: true)
      t.integer(:seat)

      t.index([:showing_id, :seat], unique: true)

      t.timestamps
    end
  end
end
