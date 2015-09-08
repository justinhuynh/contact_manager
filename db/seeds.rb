require 'faker'

contact_attributes = [
  { first_name: 'Eric', last_name: 'Kelly', phone_number: '1234567890' },
  { first_name: 'Adam', last_name: 'Sheehan', phone_number: '1234567890' },
  { first_name: 'Dan', last_name: 'Pickett', phone_number: '1234567890' },
  { first_name: 'Evan', last_name: 'Charles', phone_number: '1234567890' },
  { first_name: 'Faizaan', last_name: 'Shamsi', phone_number: '1234567890' },
  { first_name: 'Helen', last_name: 'Hood', phone_number: '1234567890' },
  { first_name: 'Corinne', last_name: 'Babel', phone_number: '1234567890' }
]

contact_attributes.each do |attributes|
  Contact.create(attributes)
end

1000.times do
  attributes = {
    first_name: "#{Faker::Name.first_name}",
    last_name: "#{Faker::Name.last_name}",
    phone_number: "#{Faker::Number.number(10)}"
  }
  Contact.create(attributes)
end
