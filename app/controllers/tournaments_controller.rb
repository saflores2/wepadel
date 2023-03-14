class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :fixture, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :fixture]

  def index
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
    @fixture_available = false
    if @tournament.type == "Champions League" && @participations.size == 16 && @tournament.available_places.zero?
      @fixture_available = true
      complete_matches_champions_league
    elsif @tournament.type == "Express" && @participations.size == 8 && @tournament.available_places.zero?
      complete_matches_express
      @fixture_available = true
    elsif @tournament.type == "Americano" && @participations.size.even? && @participations.size <= 8 && @tournament.available_places.zero?
      @winners = false
      complete_matches_american
      @fixture_available = true
    end
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

  #CHAMPIONS LEAGUE
  def complete_matches_champions_league
    @matches = Match.where(tournament_id: @tournament.id)
    create_matches_champions_league if @matches.size.zero?
    uncompleted_matches = Match.where(tournament_id: @tournament.id, winner_id: nil)
    if uncompleted_matches.size == 7
      update_round4_champions_league
    elsif uncompleted_matches.size == 3
      update_round5_champions_league
    elsif uncompleted_matches.size == 1
      update_round6_champions_league
    end
  end

  def create_matches_champions_league_round1
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 1, first_team_id: @participations[0].id, second_team_id: @participations[1].id, first_team_name: "Pareja 1", second_team_name: "Pareja 2")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 2, first_team_id: @participations[2].id, second_team_id: @participations[3].id, first_team_name: "Pareja 3", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 3, first_team_id: @participations[4].id, second_team_id: @participations[5].id, first_team_name: "Pareja 5", second_team_name: "Pareja 6")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 4, first_team_id: @participations[6].id, second_team_id: @participations[7].id, first_team_name: "Pareja 7", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 5, first_team_id: @participations[8].id, second_team_id: @participations[9].id, first_team_name: "Pareja 9", second_team_name: "Pareja 10")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 6, first_team_id: @participations[10].id, second_team_id: @participations[11].id, first_team_name: "Pareja 11", second_team_name: "Pareja 12")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 7, first_team_id: @participations[12].id, second_team_id: @participations[13].id, first_team_name: "Pareja 13", second_team_name: "Pareja 14")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 8, first_team_id: @participations[14].id, second_team_id: @participations[15].id, first_team_name: "Pareja 15", second_team_name: "Pareja 16")
  end

  def create_matches_champions_league_round2
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 9, first_team_id: @participations[0].id, second_team_id: @participations[2].id, first_team_name: "Pareja 1", second_team_name: "Pareja 3")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 10, first_team_id: @participations[1].id, second_team_id: @participations[3].id, first_team_name: "Pareja 2", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 11, first_team_id: @participations[4].id, second_team_id: @participations[6].id, first_team_name: "Pareja 5", second_team_name: "Pareja 7")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 12, first_team_id: @participations[5].id, second_team_id: @participations[7].id, first_team_name: "Pareja 6", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 13, first_team_id: @participations[8].id, second_team_id: @participations[10].id, first_team_name: "Pareja 9", second_team_name: "Pareja 11")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 14, first_team_id: @participations[9].id, second_team_id: @participations[11].id, first_team_name: "Pareja 10", second_team_name: "Pareja 12")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 15, first_team_id: @participations[12].id, second_team_id: @participations[14].id, first_team_name: "Pareja 13", second_team_name: "Pareja 15")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 16, first_team_id: @participations[13].id, second_team_id: @participations[15].id, first_team_name: "Pareja 14", second_team_name: "Pareja 16")
  end

  def create_matches_champions_league_round3
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 17, first_team_id: @participations[0].id, second_team_id: @participations[3].id, first_team_name: "Pareja 1", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 18, first_team_id: @participations[2].id, second_team_id: @participations[1].id, first_team_name: "Pareja 3", second_team_name: "Pareja 2")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 19, first_team_id: @participations[4].id, second_team_id: @participations[7].id, first_team_name: "Pareja 5", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 20, first_team_id: @participations[6].id, second_team_id: @participations[5].id, first_team_name: "Pareja 7", second_team_name: "Pareja 6")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 21, first_team_id: @participations[8].id, second_team_id: @participations[11].id, first_team_name: "Pareja 9", second_team_name: "Pareja 12")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 22, first_team_id: @participations[10].id, second_team_id: @participations[9].id, first_team_name: "Pareja 11", second_team_name: "Pareja 10")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 23, first_team_id: @participations[12].id, second_team_id: @participations[15].id, first_team_name: "Pareja 13", second_team_name: "Pareja 16")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 24, first_team_id: @participations[14].id, second_team_id: @participations[13].id, first_team_name: "Pareja 15", second_team_name: "Pareja 14")
  end

  def create_matches_champions_league_round4
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 25, first_team_name: "1° Grupo 1", second_team_name: "2° Grupo 2")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 26, first_team_name: "1° Grupo 2", second_team_name: "2° Grupo 1")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 27, first_team_name: "1° Grupo 3", second_team_name: "2° Grupo 4")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 28, first_team_name: "1° Grupo 4", second_team_name: "2° Grupo 3")
  end

  def create_matches_champions_league_round5
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 29, first_team_name: "Ganador 1°G1-2°G2", second_team_name: "Ganador 1°G3-2°G4")
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 30, first_team_name: "Ganador 1°G2-2°G1", second_team_name: "Ganador 1°G4-2°G3")
  end

  def create_matches_champions_league_round6
    Match.create!(tournament_id: @tournament.id, round: 6, match_number: 31, first_team_name: "Ganador Primera Semi Final", second_team_name: "Ganador Segunda Semi Final")
  end

  def create_matches_champions_league
    # Fase de Grupos
    create_matches_champions_league_round1
    create_matches_champions_league_round2
    create_matches_champions_league_round3
    # Ronda 4 Cuartos de Final
    create_matches_champions_league_round4
    # Ronda 5 Semi Final
    create_matches_champions_league_round5
    # Ronda 6 Final
    create_matches_champions_league_round6
  end

  def get_team_score(id)
    first_matches = Match.where(tournament_id: @tournament.id, first_team_id: id)
    second_matches = Match.where(tournament_id: @tournament.id, second_team_id: id)
    win_matches = Match.where(tournament_id: @tournament.id, winner_id: id).size
    win_sets = 0
    win_games = 0
    first_matches.each do |m|
      sets = Game.where(match_id: m.id)
      sets.each do |s|
        win_games += s.games_first_team
        win_sets += 1 if s.games_first_team > s.games_second_team
      end
    end
    second_matches.each do |m|
      sets = Game.where(match_id: m.id)
      sets.each do |s|
        win_games += s.games_second_team
        win_sets += 1 if s.games_first_team < s.games_second_team
      end
    end
    return [win_matches, win_sets, win_games, id]
  end

  def get_group_winners(id1, id2, id3, id4)
    couple1 = get_team_score(id1)
    couple2 = get_team_score(id2)
    couple3 = get_team_score(id3)
    couple4 = get_team_score(id4)
    scores = [couple1, couple2, couple3, couple4]
    ordered_scores = scores.sort_by { |c| [c[0], c[1], c[2]] }.reverse
    #RESOLVER PROBLEMA DE EMPATES
    winner1_id = ordered_scores.first.last
    winner2_id = ordered_scores[1].last
    winner3_id = ordered_scores[2].last
    winner4_id = ordered_scores[3].last
    if @tournament.type == "Express"
      return winner1_id, winner2_id, winner3_id, winner4_id
    elsif @tournament.type == "Champions League"
      return winner1_id, winner2_id
    end
  end

  def update_round4_champions_league
    id1 = @participations[0].id
    id2 = @participations[1].id
    id3 = @participations[2].id
    id4 = @participations[3].id
    winner1_g1, winner2_g1 = get_group_winners(id1, id2, id3, id4)

    id1 = @participations[4].id
    id2 = @participations[5].id
    id3 = @participations[6].id
    id4 = @participations[7].id
    winner1_g2, winner2_g2 = get_group_winners(id1, id2, id3, id4)

    id1 = @participations[8].id
    id2 = @participations[9].id
    id3 = @participations[10].id
    id4 = @participations[11].id
    winner1_g3, winner2_g3 = get_group_winners(id1, id2, id3, id4)

    id1 = @participations[12].id
    id2 = @participations[13].id
    id3 = @participations[14].id
    id4 = @participations[15].id
    winner1_g4, winner2_g4 = get_group_winners(id1, id2, id3, id4)

    m25 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 25).first
    m25.first_team_id = winner1_g1
    m25.second_team_id = winner2_g2
    m25.save

    m26 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 26).first
    m26.first_team_id = winner1_g2
    m26.second_team_id = winner2_g1
    m26.save

    m27 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 27).first
    m27.first_team_id = winner1_g3
    m27.second_team_id = winner2_g4
    m27.save

    m28 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 28).first
    m28.first_team_id = winner1_g4
    m28.second_team_id = winner2_g3
    m28.save
  end

  def update_round5_champions_league
    m25 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 25).first
    m26 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 26).first
    m27 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 27).first
    m28 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 28).first

    m29 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 29).first
    m29.first_team_id = m25.winner_id
    m29.second_team_id = m27.winner_id
    m29.save

    m30 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 30).first
    m30.first_team_id = m26.winner_id
    m30.second_team_id = m28.winner_id
    m30.save
  end

  def update_round6_champions_league
    m29 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 29).first
    m30 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 30).first

    m31 = Match.where(tournament_id: @tournament.id, round: 6, match_number: 31).first
    m31.first_team_id = m29.winner_id
    m31.second_team_id = m30.winner_id
    m31.save
  end

  #EXPRESS
  def complete_matches_express
    @matches = Match.where(tournament_id: @tournament.id)
    create_matches_express if @matches.size.zero?
    uncompleted_matches = Match.where(tournament_id: @tournament.id, winner_id: nil)
    if uncompleted_matches.size == 8
      update_round4_express
    elsif uncompleted_matches.size == 4
      update_round5_express
    end
  end

  def create_matches_express_round1
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 1, first_team_id: @participations[0].id, second_team_id: @participations[1].id, first_team_name: "Pareja 1", second_team_name: "Pareja 2")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 2, first_team_id: @participations[2].id, second_team_id: @participations[3].id, first_team_name: "Pareja 3", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 3, first_team_id: @participations[4].id, second_team_id: @participations[5].id, first_team_name: "Pareja 5", second_team_name: "Pareja 6")
    Match.create!(tournament_id: @tournament.id, round: 1, match_number: 4, first_team_id: @participations[6].id, second_team_id: @participations[7].id, first_team_name: "Pareja 7", second_team_name: "Pareja 8")
  end

  def create_matches_express_round2
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 5, first_team_id: @participations[0].id, second_team_id: @participations[2].id, first_team_name: "Pareja 1", second_team_name: "Pareja 3")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 6, first_team_id: @participations[1].id, second_team_id: @participations[3].id, first_team_name: "Pareja 2", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 7, first_team_id: @participations[4].id, second_team_id: @participations[6].id, first_team_name: "Pareja 5", second_team_name: "Pareja 7")
    Match.create!(tournament_id: @tournament.id, round: 2, match_number: 8, first_team_id: @participations[5].id, second_team_id: @participations[7].id, first_team_name: "Pareja 6", second_team_name: "Pareja 8")
  end

  def create_matches_express_round3
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 9, first_team_id: @participations[0].id, second_team_id: @participations[3].id, first_team_name: "Pareja 1", second_team_name: "Pareja 4")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 10, first_team_id: @participations[2].id, second_team_id: @participations[1].id, first_team_name: "Pareja 3", second_team_name: "Pareja 2")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 11, first_team_id: @participations[4].id, second_team_id: @participations[7].id, first_team_name: "Pareja 5", second_team_name: "Pareja 8")
    Match.create!(tournament_id: @tournament.id, round: 3, match_number: 12, first_team_id: @participations[6].id, second_team_id: @participations[5].id, first_team_name: "Pareja 7", second_team_name: "Pareja 6")
  end

  def create_matches_express_round4
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 13, first_team_name: "1° Grupo 1", second_team_name: "2° Grupo 2")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 14, first_team_name: "1° Grupo 2", second_team_name: "2° Grupo 1")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 15, first_team_name: "3° Grupo 1", second_team_name: "4° Grupo 2")
    Match.create!(tournament_id: @tournament.id, round: 4, match_number: 16, first_team_name: "3° Grupo 2", second_team_name: "4° Grupo 1")
  end

  def create_matches_express_round5
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 17, first_team_name: "Ganador 1°G1-2°G2", second_team_name: "Ganador 1°G2-2°G1")
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 18, first_team_name: "Perdedor 1°G1-2°G2", second_team_name: "Perdedor 1°G2-2°G1")
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 19, first_team_name: "Ganador 3°G1-4°G2", second_team_name: "Ganador 3°G2-4°G1")
    Match.create!(tournament_id: @tournament.id, round: 5, match_number: 20, first_team_name: "Perdedor 3°G1-4°G2", second_team_name: "Perdedor 3°G2-4°G1")
  end

  def update_round4_express
    id1 = @participations[0].id
    id2 = @participations[1].id
    id3 = @participations[2].id
    id4 = @participations[3].id
    winner1_g1, winner2_g1, winner3_g1, winner4_g1 = get_group_winners(id1, id2, id3, id4)

    id1 = @participations[4].id
    id2 = @participations[5].id
    id3 = @participations[6].id
    id4 = @participations[7].id
    winner1_g2, winner2_g2, winner3_g2, winner4_g2 = get_group_winners(id1, id2, id3, id4)

    m13 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 13).first
    m13.first_team_id = winner1_g1
    m13.second_team_id = winner2_g2
    m13.save

    m14 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 14).first
    m14.first_team_id = winner1_g2
    m14.second_team_id = winner2_g1
    m14.save

    m15 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 15).first
    m15.first_team_id = winner3_g1
    m15.second_team_id = winner4_g2
    m15.save

    m16 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 16).first
    m16.first_team_id = winner3_g2
    m16.second_team_id = winner4_g1
    m16.save
  end

  def update_round5_express
    m13 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 13).first
    m14 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 14).first

    m17 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 17).first
    m17.first_team_id = m13.winner_id
    m17.second_team_id = m14.winner_id
    m17.save

    first_looser = m13.second_team_id == m13.winner_id ? m13.first_team_id : m13.second_team_id
    second_looser = m14.second_team_id == m14.winner_id ? m14.first_team_id : m14.second_team_id
    m18 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 18).first
    m18.first_team_id = first_looser
    m18.second_team_id = second_looser
    m18.save

    m15 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 15).first
    m16 = Match.where(tournament_id: @tournament.id, round: 4, match_number: 16).first

    m19 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 19).first
    m19.first_team_id = m15.winner_id
    m19.second_team_id = m16.winner_id
    m19.save

    first_looser = m15.second_team_id == m15.winner_id ? m15.first_team_id : m15.second_team_id
    second_looser = m16.second_team_id == m16.winner_id ? m16.first_team_id : m16.second_team_id
    m20 = Match.where(tournament_id: @tournament.id, round: 5, match_number: 20).first
    m20.first_team_id = first_looser
    m20.second_team_id = second_looser
    m20.save
  end

  def create_matches_express
    # Fase de Grupos
    create_matches_express_round1
    create_matches_express_round2
    create_matches_express_round3
    # Ronda 4 Semi Final
    create_matches_express_round4
    # Ronda 6 Final
    create_matches_express_round5
  end

  #AMERICANO
  def all_vs_all_game(players)
    case players
    when 2
      result = [[[1, 2]]]
    when 4
      result = [[[1, 3], [2, 4]], [[1, 4], [2, 3]], [[1, 2], [3, 4]]]
    when 6
      result = [[[1, 3], [2, 6], [4, 5]], [[1, 2], [3, 4], [5, 6]], [[1, 5], [2, 3], [4, 6]], [[1, 4], [2, 5], [3, 6]], [[1, 6], [2, 4], [3, 5]]]
    when 8
      result = [[[1, 8], [2, 7], [3, 6], [4, 5]], [[1, 6], [2, 4], [3, 7], [5, 8]], [[1, 7], [2, 5], [3, 4], [6, 8]], [[1, 5], [2, 3], [4, 6], [7, 8]], [[1, 2], [3, 8], [4, 7], [5, 6]], [[1, 3], [2, 6], [4, 8], [5, 7]], [[1, 4], [2, 8], [3, 5], [6, 7]]]
    end
    result
  end

  def create_matches_american
    all_games = all_vs_all_game(@participations.size)
    match_number = 1
    round_number = 1
    all_games.each do |round|
      round.each do |match|
        Match.create!(tournament_id: @tournament.id, round: round_number, match_number: match_number, first_team_id: @participations[match[0]-1].id, second_team_id: @participations[match[1]-1].id, first_team_name: "Pareja #{match[0]}", second_team_name: "Pareja #{match[1]}")
        match_number += 1
      end
      round_number += 1
    end
  end

  def complete_matches_american
    @matches = Match.where(tournament_id: @tournament.id)
    create_matches_american if @matches.size.zero?
    uncompleted_matches = Match.where(tournament_id: @tournament.id, winner_id: nil)
    if uncompleted_matches.size.zero?
      scores = []
      (0...@participations.size).to_a.each do |num|
        id = @participations[num].id
        score = get_team_score(id)
        scores << score
      end
      ordered_scores = scores.sort_by { |c| [c[0], c[1], c[2]] }.reverse
      winner1_id = ordered_scores.first.last
      winner2_id = ordered_scores[1].last
      winner3_id = ordered_scores[2].last
      @winner1 = Participation.find(winner1_id)
      @winner2 = Participation.find(winner2_id)
      @winner3 = Participation.find(winner3_id)
      @winners = true
    end
  end
end
