class Timeslot < ApplicationRecord
    def pretty_time()
        return self.time.strftime("%-I:%M %p")
    end
end
