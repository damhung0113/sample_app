class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = create_feed_items
  end

  def help; end

  def about; end

  def contact; end
end
