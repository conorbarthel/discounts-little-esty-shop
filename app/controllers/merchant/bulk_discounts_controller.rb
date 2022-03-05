class Merchant::BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    welcome = WelcomeFacade.new
    @holidays = welcome.holidays[0..2]
  end

  def new
    @bulk_discount = BulkDiscount.new
  end
end
