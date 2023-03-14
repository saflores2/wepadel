class GamesController < ApplicationController
  before_action :skip_authorization

  def create
    @game = Game.new(game_params)
    @tournament = @game.match.tournament
    if @game.games_first_team != nil && @game.games_second_team != nil
      @game.save
      redirect_to fixture_tournament_path(@tournament.id)
    end
  end

  private

  def game_params
    params.permit(:match_id, :games_first_team, :games_second_team)
  end
end
