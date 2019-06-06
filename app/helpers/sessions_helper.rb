# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def make_long_duration_cookie_for(user)
    user.make_cookie_token!
    cookies[:user_token] = { value: user.cookie_token, expires: 1.weeks.from_now }
    cookies.signed[:user_id] = { value: user.id, expires: 1.weeks.from_now }
  end

  def current_user
    User.find(cookies.signed[:user_id]) if cookies[:user_id].present?
  end
end
