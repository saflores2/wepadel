class MatchesController < ApplicationController
  before_action :skip_authorization

  def update
    @match = Match.find(params[:id])
    @tournament = @match.tournament
    sets = Game.where(match_id: @match.id)
    win_sets_first_team = sets.where("games_first_team > games_second_team").size
    win_sets_second_team = sets.where("games_first_team < games_second_team").size
    if win_sets_first_team > win_sets_second_team
      @match.winner_id = @match.first_team_id
    elsif win_sets_first_team < win_sets_second_team
      @match.winner_id = @match.second_team_id
    else
      flash.alert = "Se debe ingresar un set de desempate"
    end
    @match.save
    redirect_to fixture_tournament_path(@tournament.id)
  end
end
