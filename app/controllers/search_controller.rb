class SearchController < ApplicationController
  before_action :set_param
  before_action :authenticate_user!

  def index
    @statuses = current_user.team.statuses.search(
      @query,
      page: @page,
      order: { created_at: :desc },
      per_page: 20)
  end

  private

  def set_param
    @query = params[:query]
    @page = params[:page]
  end
end
