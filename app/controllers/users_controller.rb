class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :authenticate_user!

  def index
    @users = current_user.team.users.page(params[:page])
  end

  def show
    @statuses = @user.statuses.order(updated_at: :desc).page(params[:page])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :title, :team_id)
  end
end
