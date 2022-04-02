class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table(:bookings) do |t|
      t.references(:showing, null: false, foreign_key: true)
      t.integer(:seat)

      t.timestamps
    end
  end
end
