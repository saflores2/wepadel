class TournamentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def my_tournaments?
    true
  end

  def fixture?
    true
  end
end
