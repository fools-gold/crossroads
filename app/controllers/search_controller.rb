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

  def autocomplete
    render json: Hashtag.search(
        @query,
        autocomplete: true,
        limit: 10).map { |i| "#" + i.name }
  end

  private

  def set_param
    @query = params[:query]
    @page = params[:page]
  end
end
