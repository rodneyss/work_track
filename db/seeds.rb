
Company.destroy_all
User.destroy_all
Payslip.destroy_all
Client.destroy_all
Job.destroy_all


admin = User.create(name: 'admin', email: 'admin@site.com', password: "01Mpw4wtit", boss: true, admin: true)

company1 = Company.create(name: 'Wello Plumbing', address: "55 Melrose Drive")
client1 = Client.create(name: 'Link real estate', address: "3A Linken parade North Street")
client2= Client.create(name: 'Hamilton Homes', address: "423/2 Flinders Ave St Mary's")

job1 = Job.create(address: "21 union street St leonards")
payslip1 = Payslip.create()

boss1 = User.create(name: 'Tom Lindsey', email: 'tom@site.com', password: "01Mpw4wtit", boss: true)
worker1 = User.create(name: 'Jesse Wellington', email: 'jesse@site.com', password: "password")
worker2 = User.create(name: 'Ben Maple', email: 'ben@site.com', password: "password")
worker3 = User.create(name: 'Mathew Sharp', email: 'mathew@site.com', password: "password")

company1.users << boss1 << worker1 << worker2 << worker3
company1.clients << client1 << client2
company1.payslips << payslip1

company1.jobs << job1

client1.jobs << job1

payslip1.jobs << job1

worker1.payslips << payslip1
