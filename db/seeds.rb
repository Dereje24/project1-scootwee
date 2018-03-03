# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Local.delete_all
Vehicle.delete_all
position=[37.78317009,-122.38788812,37.77009658,-122.43696013,
37.78430452,-122.43240438,
37.79272767,-122.42420559,
37.78903522,-122.40411756,
37.76153446,-122.41936672,
37.79968137,-122.42678937,
37.75454011,-122.44374842,
37.75909595,-122.41999152,
37.76408153,-122.4464512,
]
20.times do |index|
if index % 2 == 0
a=Local.create(name: Faker::Name.name ,max: 10, street: Faker::Address.street_address, city: 'San francisco', state:'CA' , zip_code:'94016',lat: position[index],lng:position[index+1])
6.times do
b=a.vehicle.create(sn: Faker::Bitcoin.address , value: Faker::Number.number(3),description:Faker::Name.name)
end
end
end
