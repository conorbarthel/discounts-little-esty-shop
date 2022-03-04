require 'rails_helper'

RSpec.describe 'The Bulk Discounts Index' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
    @not_there = Merchant.create!(name: 'Not There')
    @discount1 = @katz.bulk_discounts.create!(percentage_discount:20,
                                              quantity_threshold:10)
    @discount2 = @katz.bulk_discounts.create!(percentage_discount:10,
                                              quantity_threshold:5)
    @discount3 = @not_there.bulk_discounts.create!(percentage_discount:50,
                                              quantity_threshold:55)
  end

  it "Is linked to from the merchant dashboard" do
    visit merchant_dashboard_index_path(@katz)
    click_on "View all discounts"
    expect(current_path).to eq(merchant_bulk_discounts_path(@katz))
  end

  it "displays all discounts percentages, and thresholds" do
    visit merchant_bulk_discounts_path(@katz)

    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
    expect(page).to have_content(@discount2.quantity_threshold)
    expect(page).to have_content(@discount2.percentage_discount)
    expect(page).to_not have_content(@discount3.percentage_discount)
    expect(page).to_not have_content(@discount3.quantity_threshold)
  end

  it "Each discount has a link to its show page" do
    visit merchant_bulk_discounts_path(@katz)

    within 'discounts-0' do
      expect(page).to have_link('View Discount')
    end
    within 'discounts-1' do
      expect(page).to have_link('View Discount')
    end
  end
end
