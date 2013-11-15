class PollsController < ApplicationController
  def index
    @polls = Poll.all
  end

  def show
    set_poll
  end

  def new
    @poll = Poll.new
    @teams = Team.all.order('name ASC')
  end

  def create
    @poll = Poll.new(poll_params)

    if @poll.active == true
      # If you want to activate the new poll, deactivate any previous activated ones
      # In the future, we'll only deactivate ones that are active AND have the same phone number as the new one
      Poll.where(:active => true).update_all(:active => false)
    end

    if @poll.save
      ActiveRecord::Base.transaction do
        params['team'].each do |k, t|
          Demo.create(:poll_id => @poll.id, :team_id => k)
        end
      end
      redirect_to polls_path, notice: 'Poll was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    set_poll

    # Mark any active polls (should only be one) as inactive
    # In the future, we'll only deactivate polls that are active AND have the same phone number as the currently changed one
    Poll.where(:active => true).update_all(:active => false)
    @poll.active = true

    if @poll.save
      flash[:success] = "The poll has been activated."

      # This assumes polls will only be updated to change their active state, which is true for now
      render :nothing => true
    else
      flash[:success] = "There was an error."
      render 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:active, :date, :phone_number)
    end

end
