# frozen_string_literal: true

class Api::IssuesController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  include SessionsHelper

  def index
    @issues = current_user.issues
    render json: @issues, status: 200
  end

  def create
    @issue = current_user.issues.new(issue_params)
    if @issue.save
      render json: @issue, status: 200
    else
      render json: @issue.errors.full_messasges, status: 400
    end
  end

  private

  def issue_params
    params.permit(:title, :status, :dead_line_on, :user_id)
  end
end
