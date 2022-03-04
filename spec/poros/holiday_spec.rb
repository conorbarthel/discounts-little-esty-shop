require 'rails_helper'

RSpec.describe "holiday api" do
  it "retrives date and name of next holidays" do
    welcome = WelcomeFacade.new
    next_holidays = welcome.holidays
    expect(next_holidays).to be_an(Array)
  end
end
