class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :merchants

  def get_name_from_invoice
    item.name
  end

  def display_price
    cents = self.unit_price
    '%.2f' % (cents / 100.0)
  end

  def best_discount
    bulk_discounts.where('bulk_discounts.quantity_threshold <= ?', quantity)
    .order(percentage_discount: :desc)
    .limit(1)
    .pluck(:percentage_discount)
    .first
  end

  def item_revenue
    if best_discount != nil
      (quantity * unit_price) * (best_discount / 100.0)
    else
      quantity * unit_price
    end
  end
end
