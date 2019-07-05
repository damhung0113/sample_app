class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: get_session_email

    if user&.authenticate(params[:session][:password])
      flash[:success] = t ".welcome"
      log_in user
      check_session_remember ? remember(user) : forget(user)
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

  private

  def get_session_email
    params[:session][:email].downcase
  end

  def check_session_remember
    params[:session][:remember_me] == "1"
  end
end
