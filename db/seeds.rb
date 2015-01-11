# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

3.times do
  team = Team.create name: Faker::Company.name

  5.times do
    user = team.users.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )

    10.times do
      sentence = Faker::Lorem.sentence.split
      sentence << "##{sentence.pop}" if rand(4).zero?
      user.statuses.create description: sentence.shuffle.join(' ')
    end
  end
end
