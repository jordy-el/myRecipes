class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_rand_cookie

  private

  def set_rand_cookie
    cookies[:rand_seed] ||= {value: rand, expires: Time.now + 900}
  end
end
