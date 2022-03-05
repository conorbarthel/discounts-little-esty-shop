class Merchant::BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    welcome = WelcomeFacade.new
    @holidays = welcome.holidays[0..2]
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.create(bulk_discount_params)
    if bulk_discount.id == nil
      flash[:alert] = "All fields must be filled in with valid data"
      redirect_to new_merchant_bulk_discount_path(merchant)
    else
      redirect_to merchant_bulk_discounts_path(merchant)
    end
  end

  private
    def bulk_discount_params
      params.require(:bulk_discount).permit(:percentage_discount,
                                            :quantity_threshold)
    end
end
