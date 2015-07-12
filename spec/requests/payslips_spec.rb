require 'rails_helper'

RSpec.describe "Payslips", type: :request do
  describe "GET /payslips" do
    it "works! (now write some real specs)" do
      get payslips_path
      expect(response).to have_http_status(200)
    end
  end
end
