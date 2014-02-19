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

  private
  def get_cat
    @cat = Cat.find(params[:id])
  end

  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :sex, :color)
  end
end
