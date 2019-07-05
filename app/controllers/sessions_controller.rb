class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      flash[:succes] = t ".success"
      @save_email = user.email
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
