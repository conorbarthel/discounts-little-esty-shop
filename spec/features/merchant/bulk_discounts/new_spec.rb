require 'rails_helper'

RSpec.describe 'The Bulk Discounts New Page' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
  end

  it "is linked to from the merchant bulk discounts page" do
    visit merchant_dashboard_index_path(@katz)
    click_on "Create New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@katz))
  end

  it "When the form is submitted with valid data user is redirected to
  bulk discount index page" do
    visit new_merchant_bulk_discount_path(@katz)
    fill_in 'percentage_discount', with: 35
    fill_in 'quantity_threshold', with: 40
    click_on 'Create Bulk Discount'

    expect(current_path).to eq(merchant_dashboard_index_path(@katz))
  end


end
