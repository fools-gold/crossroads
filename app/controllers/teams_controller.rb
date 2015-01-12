class TeamsController < ApplicationController
  before_action :set_team, except: [:create, :new]
  before_action :authenticate_user!

  def edit
    @team.build_integration if @team.integration.nil?
  end

  def show
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      # render :edit
    end
  end

  private

  def set_team
    @team = current_user.team
  end

  def team_params
    params.require(:team).permit(:name, integration_attributes: [:webhook_url])
  end
end
