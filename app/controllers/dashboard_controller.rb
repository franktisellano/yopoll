class DashboardController < ApplicationController
  def index
    @poll = Poll.where(:active => true).first
  end
end
