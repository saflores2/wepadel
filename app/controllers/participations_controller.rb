class ParticipationsController < ApplicationController
  before_action :skip_authorization

  def create
    @participation = Participation.new
    @participation.user = current_user
    @participation.tournament_id = params[:tournament_id]
    @participation.status = "solicitado"
    find_partner
    if validate_users_in_tournament?
      @participation.save
      redirect_to payment_participation_path(@participation.id)
    else
      flash.alert = "Jugador ya registrado en este torneo"
      redirect_back(fallback_location: tournament_path(params[:tournament_id]))
    end
  end

  def my_participations
    my_tournaments = current_user.tournaments
    other_tournaments = current_user.partner_tournaments
    @tournaments = my_tournaments + other_tournaments
    # tournaments = Tournament.where(user_id: current_user.id)
    # @participations = []
    # tournaments.each do |tourna|
    #   @participations += tourna.participations
    # end
  end

  def payment
  end

  def confirmation
  end

  private

  def find_partner
    if params[:participation][:partner_email] != ""
      partner = User.find_by(email: params[:participation][:partner_email])
      if partner != nil && partner.email != current_user.email
        @participation.partner_id = partner.id
        @participation.partner_email = params[:participation][:partner_email]
      end
    # else
    #   @participation.partner_id = current_user.id
    end
  end

  def validate_users_in_tournament?
    user_participation = Participation.find_by(tournament_id: params[:tournament_id], user_id: current_user.id)
    user_other_participation = Participation.find_by(tournament_id: params[:tournament_id], partner_id: current_user.id)
    partner_participation = Participation.find_by(tournament_id: params[:tournament_id], user_id: @participation.partner_id)
    partner_other_participation = Participation.find_by(tournament_id: params[:tournament_id], partner_id: @participation.partner_id)
    if user_participation.nil? && partner_participation.nil? && user_other_participation.nil? && partner_other_participation.nil?
      return true
    else
      return false
    end
  end

end
