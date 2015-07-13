require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(:password => "password"),
      User.create!(:password => "password")
    ])
  end

  it "renders a list of users" do
    render
  end
end
