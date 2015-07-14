require 'faker'
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
admin = User.create(name: 'admin', email: 'admin@site.com', password: "password", boss: true, admin: true)

company1 = Company.create(name: 'Wello Plumbing', address: Faker::Address.street_address)
client1 = Client.create(name: 'Link real estate', address: Faker::Address.street_address)

job1 = Job.create(address: Faker::Address.street_address)
payslip1 = Payslip.create()

boss1 = User.create(name: 'tom', email: 'tom@site.com', password: "password", boss: true)
worker1 = User.create(name: 'jesse', email: 'jesse@site.com', password: "password")

company1.users << boss1 << worker1
company1.clients << client1

company1.jobs << job1

client1.jobs << job1

payslip1.jobs << job1

worker1.payslips << payslip1
