class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @attachment = @micropost.attachments.build
      @feed_items = create_feed_items
    end
  end

  def help; end

  def about; end

  def contact; end
end
