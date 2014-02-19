class CatsController < ApplicationController
  # before_filter :get_cat, [:show]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    get_cat
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      # redirect_to new_cat_url
      render :new
    end
  end

  def edit
    get_cat
    render :edit
  end

  def update
    get_cat
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def get_cat
    @cat = Cat.find(params[:id])
  end

  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :sex, :color)
  end
end
