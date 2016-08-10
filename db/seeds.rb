# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Rake::Task['db:reset'].invoke

orgs_list = [
  ["Food for the Poor", "Food Pantry", "Michelle Gondalez", "954-427-222", "6401 Lyons Road", "Coconut Creek", "FL", "33073", "org1@example.com", "1234", "Food For The Poor, Inc. (FFP) is an ecumenical Christian nonprofit organization based in Coconut Creek, Florida, USA that provides food, medicine, and shelter, among other services, to the poor in Latin America and the Caribbean."],
  ["Cross International Catholic Outreach", "Shelter", "Chelsey Simmons", "561-392-921", "2700 N. Military TrailSuite 240" , "Boca Raton", "FL", "33427", "org2@example.com", "1234", "Cross International (CI) is a Christian relief and development organization based in South Florida, United States, that provides food, shelter, water, education, medical care and emergency aid to the poor in over 36 developing countries across the globe."],
  ["Family Central", "Shelter", "Sharlene O'Donnell", "954-720-1000", "840 S.W. 81st Ave.", "North Lauderdale", "FL", "33068", "org3@example.com", "1234", "Family Central (FC) is the epicenter for comprehensive family strengthening, early learning and training in South Florida.  FC continues to transform lives  providing quality family shelter  services so that every child and family can succeed."],
  ["Early Learning Coalition of Miami-Dade/Monroe Inc.", "Food Pantry","Mike Westin", "305-646-7220", "2555 Ponce de Leon Blvd. 5th floor", "Coral Gables", "FL", "33134", "org4@example.com", "1234", "The Early Learning Coalition of Miami-Dade/Monroe is a nonprofit organization dedicated to ensuring early care and education for children in Miami-Dade and Monroe counties. Through a variety of affordable and innovative early education and voluntary pre-kindergarten programs, the Coalition serves more than 50,000 children ages birth to 12 years old and their families."],
  ["Our Kids of Miami-Dade/Monroe", "Soup Kitchen", "Jose Hernandez", "305-455-6000", "401 N.W. Second Ave. 10th floor", "Miami", "FL", "33128", "org5@example.com",  "1234", "Our Kids of Miami-Dade/Monroe (OFM) is a non-profit organisation that provides free meal for underprivileged children in the Miami-Dade/Monroe area. The goal of OFM is to provide institutional reforms that improve children's access to nutritional meals"]
]
organizations = orgs_list.map do |org_name , org_type , contact_name , contact_number , street_address, city , state , zip_code , email , password, description|

  Organization.create(org_name: org_name, org_type: org_type, contact_name: contact_name, contact_number: contact_number, street_address: street_address, city: city, state: state, zip_code: zip_code, email: email, password: password, description: description)
end
p Organization.all

events_list = [
  ["Food Giveaway" , "2016-08-18", "8:00:00", "3600 West Sample Road" , "Coconut Creek", "FL", "33073", "Distribute food to underprivileged residents of Coconut Creek who have difficulty purchasing enough food to avoid hunger, food donations are welcome."],

  ["Hands are for Helping" ,  "2016-08-18", "9:00:00", "4000 Morikami Park Rd", "Boca Raton", "FL", "33427", "Give art lessons to encourage underprivileged 6-12 year olds students to share supplies and to work cooperatively together in the classroom while completing an art activity, art supplies donations are welcome" ],

  ["Mending Hearts with Hope" ,  "2016-08-23", "10:00:00", "1950 Eisenhower Boulevard", "North Lauderdale", "FL", "33068", "Volunteer at the North Lauderdale Animal Shelter by feeding pets and cleaning pets cages, pet supplies donations are welcome."],

  ["Coral Gables Helping Hands" , "2016-08-29", "11:00:00", "285 Aragon Avenue","Coral Gables", "FL", "33134", "Distribute clothes and swimsuits according to their age, size and children's name at Coral Gables, clothing donations are welcome." ],

  ["Toys for Tots" ,  "2016-08-27", "10:00:00", "5701 Sunset Dr" , "Miami", "FL", "33128", "Sort and distribute toys to underprivileged children from ages 3-12 years old in Miami. Toys dropoffs are welcome."]
]
events_list.zip(organizations) do |event, organization|
  event_name, date, time, street_address, city, state, zip_code, description = event
  ev = Event.create(organization: organization, event_name: event_name, date: date, time: time, street_address: street_address, city: city, state: state, zip_code: zip_code, description: description)
  # p ev.errors
end
p Event.all
