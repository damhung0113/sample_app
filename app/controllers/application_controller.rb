class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".login_first"
    redirect_to login_path
  end

  def create_feed_items
    @feed_items = current_user.feed.sort_by_time.page(params[:page])
      .per Settings.user.helpers.post_per_page
  end
end
