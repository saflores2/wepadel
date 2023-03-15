class ParticipationsController < ApplicationController
  before_action :skip_authorization
  before_action :set_participation, only: [:payment, :confirmation]

  def create
    @participation = Participation.new
    @participation.user = current_user
    @participation.tournament_id = params[:tournament_id]
    @participation.status = "solicitado"
    find_partner if valid_partner?
    @participation.save
    flash.alert = "Correo de pareja no válido, puedes continuar con tu inscripción" if @participation.partner_id == nil && params[:participation][:partner_email] != ""
    redirect_to payment_participation_path(@participation.id)
  end

  def my_participations
    @payed_participations = current_user.participations.where(status: "pagado") + current_user.partner_participations.where(status: "pagado")
    @not_payed_participations = current_user.participations.where(status: "solicitado") + current_user.partner_participations.where(status: "solicitado")
  end

  def payment
    if @tournament.available_places.zero?
      flash.alert = "Lo siento, no quedan cupos en este torneo."
      redirect_to tournament_path(@tournament.id)
    else
      redirect_to new_participation_payment_path(@participation.id)
    end
  end

  def confirmation
    if @tournament.available_places.positive?
      @tournament.available_places -= 1
      @tournament.save
      @participation.status = "pagado"
      @participation.save
    else
      flash.alert = "Lo siento, no quedan cupos en este torneo."
      redirect_to tournament_path(@tournament.id)
    end
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
    @tournament = @participation.tournament
  end

  def validate_partner_in_tournament?
    partner_participation = Participation.find_by(tournament_id: params[:tournament_id], partner_id: current_user.id)
    partner_other_participation = Participation.find_by(tournament_id: params[:tournament_id], partner_id: @participation.partner_id)
    if partner_participation.nil? && partner_other_participation.nil?
      return true
    else
      return false
    end
  end

  def valid_partner?
    if params[:participation][:partner_email] != @participation.tournament.user[:email] &&
       params[:participation][:partner_email] != current_user.email &&
       params[:participation][:partner_email] != "" &&
       validate_partner_in_tournament?
      true
    else
      false
    end
  end

  def find_partner
    partner = User.find_by(email: params[:participation][:partner_email])
    if partner != nil
      @participation.partner_id = partner.id
      @participation.partner_email = params[:participation][:partner_email]
    end
  end

  def set_payment
    require 'mercadopago'
    # Agrega credenciales
    # sdk = Mercadopago::SDK.new(ENV['MP_ENV'])
    sdk = Mercadopago::SDK.new('TEST-8176056889804520-031416-7a4c5991c28d53e89ad27244c6bd599c-635661916')
    # sdk = Mercadopago::SDK.new('TEST-5635626968426827-030609-8da4baa7bbfe680d16a205b3c2db1afb-325153089')
    preference_data = {
      items: [
        {
          title: "#{@tournament.name}",
          unit_price: @tournament,
          quantity: 1
        }
      ]
    }
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]

    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
  end
end
