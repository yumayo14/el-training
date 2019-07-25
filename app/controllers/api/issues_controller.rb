# frozen_string_literal: true

class Api::IssuesController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @issues = User.first.issues
    render json: @issues, status: 200
  end
end
