class DemosController < ApplicationController
  def update
    set_demo

    # Mark any active demos (should only be one) as inactive
    # In the future, we'll only deactivate polls that are active AND have the same phone number as the currently changed one
    Demo.where('active = ? AND poll_id = ?', true, @demo.poll_id).update_all(:active => false)
    @demo.active = true

    if @demo.save
      flash[:success] = "The poll has been activated."

      Pusher['dashboard_channel'].trigger('change_active', data: {
        'new_active_team_id'=> @demo.team_id
      })

    else
      flash[:success] = "There was an error."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo
      @demo = Demo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demo_params
      params.require(:demo).permit(:active)
    end
end
