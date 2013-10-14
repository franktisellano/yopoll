class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    set_team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to teams_path, notice: 'Team was successfully created.'
    else
      render action: 'new'
    end
  end

  # def update
  #   set_poll

  #   # Mark any active polls (should only be one) as inactive
  #   # In the future, we'll only deactivate polls that are active AND have the same phone number as the currently changed one
  #   Poll.where(:active => true).update_all(:active => false)
  #   @poll.active = true

  #   if @poll.save
  #     flash[:success] = "The poll has been activated."
  #     redirect_to polls_path
  #   else
  #     flash[:success] = "There was an error."
  #     render 'edit'
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end

end
