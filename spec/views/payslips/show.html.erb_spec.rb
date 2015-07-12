require 'rails_helper'

RSpec.describe "payslips/show", type: :view do
  before(:each) do
    @payslip = assign(:payslip, Payslip.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
