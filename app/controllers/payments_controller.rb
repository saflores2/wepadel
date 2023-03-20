class PaymentsController < ApplicationController
  before_action :skip_authorization
  skip_before_action :verify_authenticity_token

  def new
    @participation = Participation.find(params[:participation_id])
    @tournament = @participation.tournament
    @payment = Payment.new
    session[:participation_id] = @participation.id
  end

  def index
  end

  def show
    @payment = Payment.find(params[:id])
    @participation = @payment.participation
    @tournament = @participation.tournament
  end

  def process_payment
    require 'mercadopago'
    sdk = Mercadopago::SDK.new(ENV['MP_ENV'])


    payment_data = {
      transaction_amount: params[:transaction_amount].to_f,
      token: params[:token],
      description: params[:description],
      installments: params[:installments].to_i,
      payment_method_id: params[:payment_method_id],
      payer: {
        email: params["payer"]["email"],
        identification: {
          type: params[:identificationType],
          number: params[:identificationNumber]
        },
        first_name: params[:cardholderName]
      }
    }

    payment_response = sdk.payment.create(payment_data)
    payment = payment_response[:response]
    resultado = JSON.parse(payment.to_json)
    pp resultado
    @payment = Payment.new
    @payment.status = resultado["status"]
    @payment.status_detail = resultado["status_detail"]
    @payment.mp_id = resultado["id"]
    @participation = Participation.find(session[:participation_id])
    @tournament = @participation.tournament
    if @payment.save
      @participation.payment_id = @payment.id
      @participation.save
      if @tournament.available_places.positive? && @payment.status == "approved"
        @participation.status = "pagado"
        @participation.save
        @tournament.available_places -= 1
        @tournament.save
        p @tournament
      else
        flash.alert = "Lo siento, no quedan cupos en este torneo."
        redirect_to tournament_path(@tournament.id)
      end
      redirect_to payment_path(@payment.id)
    else
      redirect_to tournament_path(@tournament.id), alert: "Pago no procesado"
    end
  end

  private
  def update_places
    @participation.status = "pagado"
    @participation.save
    old_places = @tournament.available_places
    @tournament.available_places = old_places - 1
    @tournament.save
    # @tournament.available_places +=1
    @tournament.save
    raise
  end
end
