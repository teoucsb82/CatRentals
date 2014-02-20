class CatsController < ApplicationController
  before_action :is_cat_owner, :only => [:edit, :update]

  def is_cat_owner
    get_cat
    if current_user.id != @cat.user_id
      flash.now[:errors] = ["You can only edit your own!"]
      redirect_to cat_url(@cat)
    end
  end

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
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      # redirect_to new_cat_url
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    end
  end

  private
  def get_cat
    @cat = Cat.find(params[:id])
  end

  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :sex, :color, :user_id)
  end
end
