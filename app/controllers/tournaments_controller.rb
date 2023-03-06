class TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[show, destroy]
  def index
    @tournaments = Tournament.all
  end

  def show
  end

  def new
  end

  def create
  end

  def my_tournaments
  end

  def fixture
  end

  def edit
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
