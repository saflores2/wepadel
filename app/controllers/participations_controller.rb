class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @participation.user = current_user
  end

  def my_participations
    tournaments = Tournament.where(user_id: current_user.id)
    @participations = []
    tournaments.each do |tourna|
      @participations += tourna.participations
    end
  end

  def payment
  end

  def confirmation
  end
end
