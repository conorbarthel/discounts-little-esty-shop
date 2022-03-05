require 'rails_helper'

RSpec.describe 'The Bulk Discounts Show Page' do

  it "displays the discounts percentage_discount and quantity_threshold" do
    @katz = Merchant.create!(name: 'Katz Kreations')
    @discount1 = @katz.bulk_discounts.create!(percentage_discount:20,
                                              quantity_threshold:15)
    @discount2 = @katz.bulk_discounts.create!(percentage_discount:10,
                                              quantity_threshold:5)

    visit merchant_bulk_discount_path(@katz, @discount1)

    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
    expect(page).to_not have_content(@discount2.quantity_threshold)
    expect(page).to_not have_content(@discount2.percentage_discount)
  end

end
