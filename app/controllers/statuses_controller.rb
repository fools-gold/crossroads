class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

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
      redirect_to statuses_url, notice: 'Status was successfully created.'
    else
      render :new
    end
  end

  def update
    if @status.update(status_params)
      redirect_to statuses_url, notice: 'Status was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @status.destroy
    redirect_to statuses_url, notice: 'Status was successfully destroyed.'
  end

  def today
    @active_users = current_user.team.users.active(Time.zone.today)
    @nonactive_users = current_user.team.users.nonactive(Time.zone.today)
  end

  def yesterday
    @active_users = current_user.team.users.active(Time.zone.yesterday)
    @nonactive_users = current_user.team.users.nonactive(Time.zone.yesterday)
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:description, :user_id)
  end
end
