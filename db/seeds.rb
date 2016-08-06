# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rake::Task['db:reset'].invoke

orgs_list = [
  [1, "Food for the Poor", "Food Pantry", "Michelle", "954-427-222", "6401 Lyons Road", "Coconut Creek", "FL", "33073", "org1@example.com", "1234"],
  [2, "Cross International Catholic Outreach", "Shelter", "Chelsey", "561-392-921", "2700 N. Military TrailSuite 240" , "Boca Raton", "FL", "33427", "org2@example.com", "1234"],
  [3, "Family Central", "Shelter", "Sharlene", "954-720-1000", "840 S.W. 81st Ave.", "North Lauderdale", "FL", "33068", "org3@example.com", "1234"],
  [4, "Early Learning Coalition of Miami-Dade/Monroe Inc.", "Food Pantry","Mike", "305-646-7220", "2555 Ponce de Leon Blvd. 5th floor", "Coral Gables", "FL", "33134", "org4@example.com", "1234"],
  [5, "Our Kids of Miami-Dade/Monroe", "Soup Kitchen", "Jose", "305-455-6000", "401 N.W. Second Ave. 10th floor", "Miami", "FL", "33128", "org5@example.com",  "1234"]
]
orgs_list.each do |id, org_name , org_type , contact_name , contact_number , street_address, city , state , zip_code , email , password|

Organization.create(id: id, org_name: org_name, org_type: org_type, contact_name: contact_name, contact_number: contact_number, street_address: street_address, city: city, state: state, zip_code: zip_code, email: email, password: password)
end
p Organization.all

events_list = [
  [1, "Food Giveaway" , "2016-08-06", "8:00:00", "3600 West Sample Road" , "Coconut Creek", "FL", "33073"],

  [2, "Hands are for Helping" ,  "2016-08-06", "9:00:00", "4000 Morikami Park Rd", "Boca Raton", "FL", "33427" ],

  [3, "Mending Hearts with Hope" ,  "2016-08-06", "10:00:00", "1950 Eisenhower Boulevard", "North Lauderdale", "FL", "33068"],

  [4, "Coral Gables Helping Hands" , "2016-08-06", "11:00:00", "285 Aragon Avenue","Coral Gables", "FL", "33134"],

  [5, "Toys for Tots" ,  "2016-08-06", "10:00:00", "5701 Sunset Dr" , "Miami", "FL", "33128"]
]
events_list.each do |organization_id, event_name, date , time, street_address, city , state , zip_code|

Event.create(organization_id: organization_id, event_name: event_name, date: date, time: time, street_address: street_address, city: city, state: state, zip_code: zip_code)
end
p Event.all
