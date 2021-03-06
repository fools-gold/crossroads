class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]
  before_action :authenticate_user!

  def index
    @hashtags = current_user.team.hashtags.order(updated_at: :desc).page(params[:page])
  end

  def show
    @statuses = @hashtag.statuses.order(updated_at: :desc).page(params[:page])
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find(params[:id])
  end

  def hashtag_params
    params.require(:hashtag).permit(:name)
  end
end
