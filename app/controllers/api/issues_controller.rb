class Api::IssuesController < ApplicationController
  def index
    @issues = Issue.all
    render json: { issues: @issues }, status: 200
  end
end
