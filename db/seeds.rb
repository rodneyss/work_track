Company.destroy_all
User.destroy_all
Payslip.destroy_all
Client.destroy_all
Job.destroy_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


c1 = Company.create(name: 'Wello Plumbing', address: Faker::Address.name)


boss1 = User.create(name: 'tom', email: 'tom@site.com', password: "password")

c1.users << boss1