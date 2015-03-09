class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  helper_method :users, :statuses

  def index
    @statuses = current_user.team.statuses.order(created_at: :desc).page(params[:page])
  end

  def new
    @status = current_user.statuses.build
  end

  def edit
  end

  def create
    @status = current_user.statuses.build(status_params)

    if @status.save
      redirect_to statuses_url, notice: "Status was successfully created."
    else
      render :new
    end
  end

  def update
    @status.photo = nil if params[:remove_status_photo] == "true"
    if @status.update(status_params)
      redirect_to statuses_url, notice: "Status was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @status.destroy
    redirect_to statuses_url, notice: "Status was successfully destroyed."
  end

  def today
    @period = Time.zone.today.beginning_of_day.all_day
  end

  def yesterday
    @period = Time.zone.yesterday.beginning_of_day.all_day
  end

  def daily
    @date = Time.zone.local(params[:year], params[:month], params[:day]).to_date
    @prev = @date.yesterday
    @next = @date.tomorrow
    @period = @date
  end

  def monthly
    @date = Time.zone.local(params[:year], params[:month]).to_date
    @prev = @date.prev_month
    @next = @date.next_month
    @period = @date.all_month
  end

  def yearly
    @date = Time.zone.local(params[:year]).to_date
    @prev = @date.prev_year
    @next = @date.next_year
    @period = @date.all_year
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def users
    @users ||= current_user.team.users
  end

  def statuses
    @statuses ||= current_user.team.statuses.during(@period).order(created_at: :desc).page(params[:page])
  end

  def status_params
    params.require(:status).permit(:description, :user_id, :photo)
  end
end
