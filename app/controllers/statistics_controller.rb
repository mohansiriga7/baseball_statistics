class StatisticsController < ApplicationController
  def index

    #Retrieving all the players who have RBI, Home_runs, Runs, At_bats
    @search = Player.where.not(rbi: nil, home_runs: nil, runs: nil, at_bats: nil).
                          ransack(params[:q])


    #Retriving 25 players of perticular page.
     @players = @search.result(distinct: true).
                        page(params[:page]).
                        per(25)
  end


end