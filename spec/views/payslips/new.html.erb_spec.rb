require 'rails_helper'

RSpec.describe "payslips/new", type: :view do
  before(:each) do
    assign(:payslip, Payslip.new())
  end

  it "renders new payslip form" do
    render

    assert_select "form[action=?][method=?]", payslips_path, "post" do
    end
  end
end
