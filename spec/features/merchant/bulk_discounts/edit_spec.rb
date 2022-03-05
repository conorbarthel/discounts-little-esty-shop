require 'rails_helper'

RSpec.describe 'The Bulk Discounts Edit Page' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
    @discount1 = @katz.bulk_discounts.create!(percentage_discount:20,
                                              quantity_threshold:15)
    @discount2 = @katz.bulk_discounts.create!(percentage_discount:10,
                                              quantity_threshold:3)
  end

  it "is linked to from the merchant discount show page" do
    visit merchant_bulk_discount_path(@katz, @discount1)
    click_on 'Update Discount'
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@katz, @discount1))
  end

  it "has a form to edit the discount that redirects to the show page on submission" do
    visit edit_merchant_bulk_discount_path(@katz, @discount1)
    fill_in 'Percentage discount', with: 45
    fill_in 'Quantity Threshold', with: 50
    click_on 'Update Bulk discount'
    expect(current_path).to eq(merchant_bulk_discount_path(@katz, @discount1))
  end

  it "The form is pre populated with the discounts current values" do
    visit edit_merchant_bulk_discount_path(@katz, @discount1)
    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
  end

  it "After submission the values of the discount are updated" do
    visit edit_merchant_bulk_discount_path(@katz, @discount1)
    expect(@discount1.percentage_discount).to eq(20)
    expect(@discount1.quantity_threshold).to eq(15)
    fill_in 'Percentage discount', with: 45
    fill_in 'Quantity Threshold', with: 50
    click_on 'Update Bulk discount'
    expect(@discount1.percentage_discount).to eq(45)
    expect(@discount1.quantity_threshold).to eq(50)
    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
  end

  it "displays an error message if the updated values are invalid and
  redirects backs to the edit page" do
    visit edit_merchant_bulk_discount_path(@katz, @discount1)
    fill_in 'Percentage discount', with: -45
    fill_in 'Quantity Threshold', with: 50
    click_on 'Update Bulk discount'
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@katz, @discount1))
    expect(page).to have_content("All values must be valid")
  end
  
end
