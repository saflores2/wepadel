class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :fixture, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :fixture]

  def index
    # @tournaments = Tournament.all
    # @tournaments = policy_scope(Tournament.all)
    @categories = ["Masculino 1ra", "Masculino 2da", "Masculino 3ra", "Masculino 4ta", "Masculino 5ta", "Masculino 6ta",
             "Femenino A", "Femenino B", "Femenino C", "Femenino D", "Mixto A", "Mixto B", "Mixto C", "Mixto D", "Otra"]
    if params[:category].present?
      @tournaments = policy_scope(Tournament.where(categoy: params[:category]))
    else
      @tournaments = policy_scope(Tournament.all)
    end
  end

  def show
    authorize @tournament
  end

  def new
    @tournament = Tournament.new
    authorize @tournament
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user = current_user
    authorize @tournament
    if @tournament.save
      redirect_to tournament_path(@tournament.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_tournaments
    @tournaments = Tournament.where(user_id: current_user.id)
    authorize @tournaments
  end

  def fixture
    @tournament = Tournament.find(params[:id])
    authorize @tournament
  end

  def edit
    authorize @tournament
  end

  def update
    authorize @tournament
    @tournament.update(tournament_params)
    redirect_to tournament_path(@tournament.id)
  end

  def destroy
    authorize @tournament
    @tournament.destroy
    redirect_to tournaments_path, status: :see_other
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :ubication_address, :ubication_name, :start_date, :end_date, :duration,
      :type, :category, :gender, :min_matches, :max_matches, :places, :match_duration, :awards, :other, :price, :photo)
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
