class FollowingController < ApplicationController
  before_action :find_user, only: :index

  def index
    @title = t ".following"
    @users = @user.following.page(params[:page])
                  .per Settings.user.helpers.post_per_page
    render "users/show_follow"
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
  end
end
