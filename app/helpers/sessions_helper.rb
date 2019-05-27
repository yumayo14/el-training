# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def set_cookies(user)
    user.make_long_term_cookie
    cookies[:user_token] = { value: user.cookie_token, expires: 1.weeks.from_now }
    cookies.signed[:user_id] = { value: user.id, expires: 1.weeks.from_now }
  end
end
