# frozen_string_literal: true

module ViewHelper
  def formatted_flash(flash)
    flash. each do |key, value|
      concat content_tag :div, value, class: "alert alert-#{key}"
    end
  end
end
