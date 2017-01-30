# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = [ "matt", "will", "bran" ]
users = []
u.each do |user|
    users << User.create!( first_name: user, last_name: "Chinn", 
                  email: "#{user}@gmail.com", password: "asdfasdf" )
end

trump = Debate.create(title: "Trump", description: "Will he Make America Great Again?")
pro1 = Argument.create!(title: "Yes", description: "He will", proponent: true, links: %w(foxnews.com), debate_id: trump.id, creator_id: users[0].id)
pro2 = Argument.create!(title: "Also yes", description: "Also he will", proponent: true, debate_id: trump.id, creator_id: users[1].id)

con1 = Argument.create!(title: "No", description: "He won't", proponent: false, links: %w(google.com), debate_id: trump.id, creator_id: users[2].id)
con2 = Argument.create!(title: "Also no", description: "Also he won't", proponent: false, debate_id: trump.id, creator_id: users[0].id)
con3 = Argument.create!(title: "In fact, no", description: "Alternative facts aren't facts", proponent: false, debate_id: trump.id, creator_id: users[1].id)

pro1.supporting_arguments << pro2
con1.supporting_arguments << con2
pro2.counter_arguments << con3
