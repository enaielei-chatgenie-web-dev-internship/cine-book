# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

words = "
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tincidunt lectus sit amet turpis sollicitudin condimentum. Pellentesque pellentesque, odio sit amet semper iaculis, enim felis fringilla tortor, id egestas sem metus auctor quam. Vestibulum tristique consectetur neque in efficitur. Nullam porta est diam, ut tristique quam tempor quis. Sed bibendum, erat vitae tempor feugiat, ex purus mollis lectus, et semper risus diam vitae arcu. Nulla pretium faucibus sapien et interdum. Aenean ex nunc, pharetra ut dui in, congue rhoncus turpis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent lacinia luctus diam vel egestas. Nam consectetur luctus ex nec mollis. Nulla lacinia nec lectus eu elementum. Cras vestibulum mi in lectus malesuada porta.
".split(" ")

User.create(
    email: "admin@email.com",
    full_name: "Admin",
    mobile_number: "09292867454",
    password: "123456",
    password_confirmation: "123456",
    activated: true
)

Timeslot.create(
    time: "10:00 AM",
    label: "Morning"
)

Timeslot.create(
    time: "2:00 PM",
    label: "Afternoon"
)

Timeslot.create(
    time: "6:00 PM",
    label: "Evening"
)

Timeslot.create(
    time: "10:00 PM",
    label: "Night"
)

for i in 0..19
    Cinema.create(
        name: words.shuffle()[..10].join(" "),
        location: words.shuffle()[..30].join(" "),
    )

    Movie.create(
        title: words.shuffle()[..10].join(" "),
        description: words.shuffle()[..30].join(" "),
    )

    Showing.create(
        cinema_id: Cinema.all.sample.id,
        movie_id: Movie.all.sample.id,
        timeslot_id: Timeslot.all.sample.id,
    )
end
