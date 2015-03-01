class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :edit]

  def show
  end

  def update
    if @team.update(team_params)
      redirect_to team_url, notice: 'Your team was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    redirect_to root_url unless current_user.admin?
  end

  private

  def set_team
    @team = current_user.team
  end

  def team_params
    params.require(:team).permit(:name, :description)
  end

end
