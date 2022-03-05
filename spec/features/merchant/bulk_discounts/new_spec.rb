require 'rails_helper'

RSpec.describe 'The Bulk Discounts New Page' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
  end

  it "is linked to from the merchant bulk discounts page" do
    visit merchant_bulk_discounts_path(@katz)
    click_on "Create New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@katz))
  end

  it "When the form is submitted with valid data user is redirected to
  bulk discount index page" do
    visit new_merchant_bulk_discount_path(@katz)
    fill_in 'Percentage discount', with: 35
    fill_in 'Quantity threshold', with: 40
    click_on 'Create Bulk discount'

    expect(current_path).to eq(merchant_bulk_discounts_path(@katz))
  end

  it "if the form is submitted with invalid data the user is redirected
  to the new page with an error message" do
    visit new_merchant_bulk_discount_path(@katz)
    fill_in 'Percentage discount', with: 150
    fill_in 'Quantity threshold', with: 40
    click_on 'Create Bulk discount'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@katz))
    expect(page).to have_content("All fields must be filled in with valid data")

    fill_in 'Percentage discount', with: 50
    fill_in 'Quantity threshold', with: -40
    click_on 'Create Bulk discount'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@katz))
    expect(page).to have_content("All fields must be filled in with valid data")

    fill_in 'Percentage discount', with: -50
    fill_in 'Quantity threshold', with: 40
    click_on 'Create Bulk discount'
    
    expect(current_path).to eq(new_merchant_bulk_discount_path(@katz))
    expect(page).to have_content("All fields must be filled in with valid data")
  end
end
