# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create([
  {
    email: 'admin@events.com',
    password: 'admin',
    role: 'admin'
  },
  {
    email: 'dan@events.com',
    password: 'test'
  }
])

TYPES = %w[WorkShop OfficeHour].freeze

def generate_participants(type)
  return 1 if type == 'OfficeHour'

  rand(1..1000)
end

def generate_events
  events = []

  200.times do
    start_time = Faker::Time.between(2.years.ago, DateTime.now + 2.years, :all)
    end_time = nil
    while end_time.nil? || end_time <= start_time
      end_time = Faker::Time.between(start_time, start_time.end_of_day, :all)
    end
    type = TYPES.sample
    max_participants = generate_participants(type)

    events << {
      name: Faker::FunnyName.name,
      type: type,
      speaker: Faker::Name.name,
      start_time: start_time,
      end_time: end_time,
      location: Faker::Address.full_address,
      description: Faker::Lorem.paragraph,
      max_participants: max_participants
    }
  end
  events
end

Event.create(generate_events)