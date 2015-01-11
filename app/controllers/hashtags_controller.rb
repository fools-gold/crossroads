class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  def index
    @hashtags = Hashtag.all
  end

  def show
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find(params[:id])
  end

  def hashtag_params
    params.require(:hashtag).permit(:name)
  end
end
