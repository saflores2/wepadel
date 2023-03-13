class MatchesController < ApplicationController
  before_action :skip_authorization

  def update
    @match = Match.find(params[:id])
    @tournament = @match.tournament
    if params[:winner] != ""
      winner_user = User.find_by(email: params[:winner])
      winner_participation = Participation.where(tournament_id: @tournament.id, user_id: winner_user.id).first
      @match.winner_id = winner_participation.id
      @match.save
      redirect_to fixture_tournament_path(@tournament.id)
    end
  end
end
