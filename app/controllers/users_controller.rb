class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(update edit index)
  before_action :correct_user, only: %i(update edit)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.page(params[:page])
  end

  def index
    @users = User.order(:name).page(params[:page]).per Settings.index.per_page
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".success"
      redirect_to login_path param: @user.email
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".error"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_done"
      redirect_to @user
    else
      flash[:danger] = t ".delete_failed"
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".login_first"
    redirect_to login_path
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end

  def correct_user
    find_user
    redirect_to edit_user_path current_user unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
  end
end
