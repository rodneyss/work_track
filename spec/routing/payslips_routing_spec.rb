require "rails_helper"

RSpec.describe PayslipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/payslips").to route_to("payslips#index")
    end

    it "routes to #new" do
      expect(:get => "/payslips/new").to route_to("payslips#new")
    end

    it "routes to #show" do
      expect(:get => "/payslips/1").to route_to("payslips#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/payslips/1/edit").to route_to("payslips#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/payslips").to route_to("payslips#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/payslips/1").to route_to("payslips#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/payslips/1").to route_to("payslips#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/payslips/1").to route_to("payslips#destroy", :id => "1")
    end

  end
end
