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
    fill_in 'Quantity threshold', with: 50
    click_on 'Update Bulk discount'
    expect(current_path).to eq(merchant_bulk_discount_path(@katz, @discount1))
  end

  it "The form is pre populated with the discounts current values" do
    visit edit_merchant_bulk_discount_path(@katz, @discount1)

    expect(page).to have_field('Percentage discount', with: 20)
    expect(page).to have_field('Quantity threshold', with: 15)
  end

  it "After submission the values of the discount are updated" do
    visit edit_merchant_bulk_discount_path(@katz, @discount1)
    fill_in 'Percentage discount', with: 45
    fill_in 'Quantity threshold', with: 50
    click_on 'Update Bulk discount'

    expect(page).to have_content(45)
    expect(page).to have_content(50)
  end

end
