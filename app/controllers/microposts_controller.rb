class MicropostsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :logged_in_user, only: %i(create destroy)

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      params[:attachments]["photos"].each do |p|
        @photos = @micropost.attachments.create!(:photos => p)
      end
      flash[:success] = t ".save"
      redirect_to @current_user
    else
      flash[:danger] = t".not_save"
      @feed_items = create_feed_items
      # redirect_to static_pages_home_path
      render 'static_pages/home'
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".delete"
    else
      flash[:danger] = t ".not_delete"
    end
    redirect_back fallback_location: root_path
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content,
      attachments_attributes: [photos: []])
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
