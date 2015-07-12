require 'rails_helper'

RSpec.describe "payslips/edit", type: :view do
  before(:each) do
    @payslip = assign(:payslip, Payslip.create!())
  end

  it "renders the edit payslip form" do
    render

    assert_select "form[action=?][method=?]", payslip_path(@payslip), "post" do
    end
  end
end
