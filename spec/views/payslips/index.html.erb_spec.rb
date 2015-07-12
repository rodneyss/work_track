require 'rails_helper'

RSpec.describe "payslips/index", type: :view do
  before(:each) do
    assign(:payslips, [
      Payslip.create!(),
      Payslip.create!()
    ])
  end

  it "renders a list of payslips" do
    render
  end
end
