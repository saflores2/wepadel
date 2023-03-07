class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :fixture, :destroy]

  def index
    @tournaments = Tournament.all
  end

  def show
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user = current_user
    # authorize @product
    if @tournament.save
      redirect_to tournament_path(@tournament.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_tournaments
    @tournaments = Tournament.where(user_id: current_user.id)
    # authorize @tournament
  end

  def fixture
  end

  def edit
    # authorize @product
  end

  def update
    # authorize @product
    @tournament.update(tournament_params)
    redirect_to tournament_path(@tournament.id)
  end

  def destroy
    # authorize @product
    @tournament.destroy
    redirect_to tournaments_path, status: :see_other
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :ubication_address, :ubication_name, :start_date, :end_date, :duration,
      :type, :category, :gender, :min_matches, :max_matches, :places, :match_duration, :awards, :other, :price)
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
