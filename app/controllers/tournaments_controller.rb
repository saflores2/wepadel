class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :fixture, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :fixture]

  def index
    # @tournaments = Tournament.all
    # @tournaments = policy_scope(Tournament.all)
    @categories = ["Masculino 1ra", "Masculino 2da", "Masculino 3ra", "Masculino 4ta", "Masculino 5ta", "Masculino 6ta",
             "Femenino A", "Femenino B", "Femenino C", "Femenino D", "Mixto A", "Mixto B", "Mixto C", "Mixto D", "Otra"]
    @types = ["Champions League", "Americano", "Express"]
    @tournaments = policy_scope(Tournament.all)
    @tournaments = policy_scope(@tournaments.where(category: params[:category])) if params[:category].present?
    @tournaments = policy_scope(@tournaments.where(type: params[:type])) if params[:type].present?
    @tournaments = policy_scope(@tournaments.where(type: params[:type])) if params[:type].present?
    @tournaments = policy_scope(@tournaments.where("price <= (?)", params[:max_price])) if params[:max_price].present?
    @tournaments = policy_scope(@tournaments.where("start_date >= (?)", params[:start_date])) if params[:start_date].present?
    @tournaments = policy_scope(@tournaments.where("end_date <= (?)", params[:end_date])) if params[:end_date].present?


  end

  def show
    authorize @tournament
    @participation = Participation.new
  end

  def new
    @tournament = Tournament.new
    authorize @tournament
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user = current_user
    @tournament.available_places = @tournament.places
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
    @participations = Participation.where(tournament_id: @tournament.id, status: "pagado")
    if @tournament.type == "Champions League"
      @matches = Match.where(tournament_id: @tournament.id)
      create_matches_champions_league if @matches.size.zero?
      uncompleted_matches = Match.where(tournament_id: @tournament.id, winner_id: nil)
      if uncompleted_matches.size == 7
        update_round4_champions_league
      end
    end
    # @matches = Match.where(tournament_id: @tournament.id)
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

  def create_matches_champions_league
    # Ronda 1
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 1, first_team_id: @participations[0].id, second_team_id: @participations[1].id, first_team_name: "Pareja 1", second_team_name: "Pareja 2")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 2, first_team_id: @participations[2].id, second_team_id: @participations[3].id, first_team_name: "Pareja 3", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 3, first_team_id: @participations[4].id, second_team_id: @participations[5].id, first_team_name: "Pareja 5", second_team_name: "Pareja 6")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 4, first_team_id: @participations[6].id, second_team_id: @participations[7].id, first_team_name: "Pareja 7", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 5, first_team_id: @participations[8].id, second_team_id: @participations[9].id, first_team_name: "Pareja 9", second_team_name: "Pareja 10")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 6, first_team_id: @participations[10].id, second_team_id: @participations[11].id, first_team_name: "Pareja 11", second_team_name: "Pareja 12")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 7, first_team_id: @participations[12].id, second_team_id: @participations[13].id, first_team_name: "Pareja 13", second_team_name: "Pareja 14")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 8, first_team_id: @participations[14].id, second_team_id: @participations[15].id, first_team_name: "Pareja 15", second_team_name: "Pareja 16")
    # Ronda 2
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 9, first_team_id: @participations[0].id, second_team_id: @participations[2].id, first_team_name: "Pareja 1", second_team_name: "Pareja 3")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 10, first_team_id: @participations[1].id, second_team_id: @participations[3].id, first_team_name: "Pareja 2", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 11, first_team_id: @participations[4].id, second_team_id: @participations[6].id, first_team_name: "Pareja 5", second_team_name: "Pareja 7")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 12, first_team_id: @participations[5].id, second_team_id: @participations[7].id, first_team_name: "Pareja 6", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 13, first_team_id: @participations[8].id, second_team_id: @participations[10].id, first_team_name: "Pareja 9", second_team_name: "Pareja 11")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 14, first_team_id: @participations[9].id, second_team_id: @participations[11].id, first_team_name: "Pareja 10", second_team_name: "Pareja 12")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 15, first_team_id: @participations[12].id, second_team_id: @participations[14].id, first_team_name: "Pareja 13", second_team_name: "Pareja 15")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 16, first_team_id: @participations[13].id, second_team_id: @participations[15].id, first_team_name: "Pareja 14", second_team_name: "Pareja 16")
    # Ronda 3
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 17, first_team_id: @participations[0].id, second_team_id: @participations[3].id, first_team_name: "Pareja 1", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 18, first_team_id: @participations[2].id, second_team_id: @participations[1].id, first_team_name: "Pareja 3", second_team_name: "Pareja 2")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 19, first_team_id: @participations[4].id, second_team_id: @participations[7].id, first_team_name: "Pareja 5", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 20, first_team_id: @participations[6].id, second_team_id: @participations[5].id, first_team_name: "Pareja 7", second_team_name: "Pareja 6")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 21, first_team_id: @participations[8].id, second_team_id: @participations[11].id, first_team_name: "Pareja 9", second_team_name: "Pareja 12")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 22, first_team_id: @participations[10].id, second_team_id: @participations[9].id, first_team_name: "Pareja 11", second_team_name: "Pareja 10")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 23, first_team_id: @participations[12].id, second_team_id: @participations[15].id, first_team_name: "Pareja 13", second_team_name: "Pareja 16")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 24, first_team_id: @participations[14].id, second_team_id: @participations[13].id, first_team_name: "Pareja 15", second_team_name: "Pareja 14")
    # Ronda 4 Cuartos de Final
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 25, first_team_name: "1° Grupo 1", second_team_name: "2° Grupo 2")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 26, first_team_name: "1° Grupo 2", second_team_name: "2° Grupo 1")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 27, first_team_name: "1° Grupo 3", second_team_name: "2° Grupo 4")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 28, first_team_name: "1° Grupo 4", second_team_name: "2° Grupo 3")
    # Ronda 5 Semi Final
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 29, first_team_name: "Ganador 1°G1-2°G2", second_team_name: "Ganador 1°G3-2°G4")
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 30, first_team_name: "Ganador 1°G2-2°G1", second_team_name: "Ganador 1°G4-2°G3")
    # Ronda 6 Final
    Match.create!(tournament_id: @tournament.id, round: 6, match_number: 31, first_team_name: "Ganador Primera Semi Final", second_team_name: "Ganador Segunda Semi Final")
  end

  def update_round4_champions_league
    # Group 1
    pair1_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[0].id).size
    pair2_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[1].id).size
    pair3_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[2].id).size
    pair4_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[3].id).size
    group_1 = [pair1_wins, pair2_wins, pair2_wins, pair4_wins].sort.reverse

    # Group 2
    pair5_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[4].id).size
    pair6_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[5].id).size
    pair7_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[6].id).size
    pair8_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[7].id).size
    group_2 = [pair5_wins, pair6_wins, pair7_wins, pair8_wins].sort.reverse

    # Group 3
    pair9_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[8].id).size
    pair10_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[9].id).size
    pair11_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[10].id).size
    pair12_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[11].id).size
    group_3 = [pair9_wins, pair10_wins, pair11_wins, pair12_wins].sort.reverse

    # Group 4
    pair13_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[12].id).size
    pair14_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[13].id).size
    pair15_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[14].id).size
    pair16_wins = Match.where(tournament_id: @tournament.id, winner_id: @participations[15].id).size
    group_4 = [pair13_wins, pair14_wins, pair15_wins, pair16_wins].sort.reverse
    # raise

  end
end
