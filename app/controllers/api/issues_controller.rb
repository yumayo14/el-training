# frozen_string_literal: true

class Api::IssuesController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @issues = Issue.all
    render json: { issues: @issues }, status: 200
  end
end
