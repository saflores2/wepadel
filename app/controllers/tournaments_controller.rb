class TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[show, destroy]
  def index
    @tournaments = Tournament.all
  end

  def show
  end

  def new
    @tournament = Tournament.new
  end

  def create
    # @tournament = Tournament.new(tournament_params)
    # @tournament.user = current_user
    # # authorize @product
    # if @tournament.save
    #   redirect_to tournament_path(@tournament.id)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def my_tournaments
  end

  def fixture
  end

  def edit
  end

  private

  # def tournament_params
  #   params.require(:tournament).permit(:name, :ubication_address, :ubication_name, :start_date, :end_date, :duration, :type, :category, :available,
  #                                   photos: [])
  # end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
