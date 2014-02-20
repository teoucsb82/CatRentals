class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_requests = CatRentalRequest.all
    render :index
  end

  def approve
    get_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    get_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def show
    get_cat_rental_request
    render :show
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else
      flash[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  private
  def get_cat_rental_request
    @cat_rental_request = CatRentalRequest.find(params[:id])
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

  def current_cat
    get_cat_rental_request.cat
  end

end
