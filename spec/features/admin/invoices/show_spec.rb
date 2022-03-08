require 'rails_helper'

RSpec.describe 'The Admin Invoices Show' do
  before :each do
    @merchant1 = Merchant.create!(name: "Suzy Hernandez")
    @merchant2 = Merchant.create!(name: "Juan Lopez")

    @item1 = @merchant2.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, item_status: 1)
    @item2 = @merchant2.items.create!(name: "onion", description: "red onion", unit_price: 3450, item_status: 1)
    @item3 = @merchant2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
    @item4 = @merchant1.items.create!(name: "table", description: "stuff", unit_price: 1500)

    @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')

    @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice3 =Invoice.create!(status: 0, customer_id: @customer3.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 2400, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450, status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 14500, status: 2)
    @invoice_item4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 20, unit_price: 5405, status: 2)
    @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 5405, status: 2)
  end

  describe 'lists the invoice attributes' do
    it 'will list the details of an invoice' do
      visit admin_invoice_path(@invoice1)

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content('completed')
      expect(page).to have_content(@invoice1.display_date)
      expect(page).to have_content(@invoice1.customer_name)
      expect(page).to have_content(@invoice1.revenue_display_price)
    end

    it 'lists the details of the items on the invoice' do
      visit admin_invoice_path(@invoice2)

      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content('cancelled')
      expect(page).to have_content(@invoice2.display_date)
      expect(page).to have_content(@invoice2.customer_name)

      within("#invoice_items-0") do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoice_item2.quantity)
        expect(page).to have_content(@invoice_item2.display_price)
        expect(page).to have_content(@invoice_item2.status)
      end

      within("#invoice_items-1") do
        expect(page).to have_content(@item4.name)
        expect(page).to have_content(@invoice_item4.quantity)
        expect(page).to have_content(@invoice_item4.display_price)
        expect(page).to have_content(@invoice_item4.status)
      end

      expect(page).not_to have_content(@item1.name)
      expect(page).not_to have_content(@item3.name)
    end

    it "details include total discounted revenue" do
      discount = @merchant1.bulk_discounts.create!(percentage_discount:20,
                                                    quantity_threshold:10)
      visit admin_invoice_path(@invoice2)

      expect(page).to have_content(@invoice2.discounted_revenue)
    end
  end

  describe 'admin can update the status of an invoice' do
    it 'the invoice status will display a select field that can be updated' do
      visit admin_invoice_path(@invoice3)

      expect(page).to have_content(@invoice3.id)
      expect(page).to have_content('in progress')

      select 'cancelled', from: :status
      click_button('Save')

      expect(current_path).to eq(admin_invoice_path(@invoice3))
      expect(page).to have_content(@invoice3.id)
      expect(page).to have_content('cancelled')
      expect(page).to have_content("Invoice Status Has Been Updated!")
    end
  end
end
