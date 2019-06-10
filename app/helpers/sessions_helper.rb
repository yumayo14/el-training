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

  def logged_in?
    return true if current_user.present?

    false
  end

  def require_login
    unless logged_in? # rubocop:disable Style/GuardClause
      flash[:danger] = 'ログインを行なってください'
      redirect_to login_path
    end
  end
end
