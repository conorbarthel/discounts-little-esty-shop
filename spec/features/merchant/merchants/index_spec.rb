require 'rails_helper'

RSpec.describe 'The Merchants Index Page' do
  it "displays all merchants names and links to dashboard" do
    @merchant = Merchant.create!(name: 'The Duke')
    @merchant2 = Merchant.create!(name: 'The Fluke')
    visit merchants_path

    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@merchant2.name)
    click_on "#{@merchant.name}'s Dashboard"
    expect(current_path).to eq(merchant_dashboard_index_path(@merchant))
  end
end
