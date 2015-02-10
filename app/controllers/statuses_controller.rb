class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  helper_method :users

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
    @date = Time.zone.today
  end

  def yesterday
    @date = Time.zone.yesterday
  end

  def on
    @date = Time.zone.local(params[:year], params[:month], params[:day]).to_date
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def users
    @users ||= current_user.team.users
  end

  def status_params
    params.require(:status).permit(:description, :user_id)
  end
end
