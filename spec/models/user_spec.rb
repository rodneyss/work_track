# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  phone           :string
#  address         :string
#  company_id      :integer
#  boss            :boolean          default(FALSE)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @company1 = Company.create(name: 'Wello Plumbing', address: "123 home street")
    @client1 = Client.create(name: 'Link real estate', address: "123 link street")

    @job1 = Job.create(address: "125 customers property st")
    @payslip1 = Payslip.create()

    @boss1 = User.create(name: 'tom', email: 'tom@site.com', password: "password", boss: true)
    @worker1 = User.create(name: 'jesse', email: 'jesse@site.com', password: "password")

    @company1.users << @boss1 << @worker1
    @company1.clients << @client1

    @client1.jobs << @job1

    @payslip1.jobs << @job1

    @worker1.payslips << @payslip1
  end


  it "has jobs through association" do
    expect(@worker1.jobs.first).to eq @job1

  end

  it "has a payslip" do
    expect(@worker1.payslips.first).to eq @payslip1

  end

  it "associated with a company" do
    expect(@worker1.company).to eq @company1
  end
  
end
