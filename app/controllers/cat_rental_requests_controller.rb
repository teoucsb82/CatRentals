class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_requests = CatRentalRequest.all

    render :index
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
      # redirect_to new_cat_url
      render :new
    end
  end

  def edit
    get_cat_rental_request
    render :edit
  end

  def update
    get_cat_rental_request
    if @cat_rental_request.update_attributes(cat_rental_request_params)
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash[:errors] = @cat_rental_request.errors.full_messages
      render :edit
    end
  end

  private
  def get_cat_rental_request
    @cat_rental_request = CatRentalRequest.find(params[:id])
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

end
