class PrototypesController < ApplicationController
  before_action :set_params, only: [:show, :edit]
  before_action :set_variable, only: [:update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if Prototype.create(prototype_params)
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    if Prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    prototype.destroy
    redirect_to root_path
  end

  private
  def set_params
    @prototype = Prototype.find(params[:id])
  end

  def set_variable
    prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to root_path
    end
  end

end
