class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @tournaments = Tournament.all
    @categories = ["Masculino 1ra", "Masculino 2da", "Masculino 3ra", "Masculino 4ta", "Masculino 5ta", "Masculino 6ta",
    "Femenino A", "Femenino B", "Femenino C", "Femenino D", "Mixto A", "Mixto B", "Mixto C", "Mixto D", "Otra"]
    @types = ["Champions League", "Americano", "Express"]
    @tournaments = policy_scope(Tournament.all)
    @tournaments = policy_scope(@tournaments.where(category: params[:category])) if params[:category].present?
    @tournaments = policy_scope(@tournaments.where(type: params[:type])) if params[:type].present?
    @tournaments = policy_scope(@tournaments.where("price <= (?)", params[:max_price])) if params[:max_price].present?
    @tournaments = policy_scope(@tournaments.where("start_date >= (?)", params[:start_date])) if params[:start_date].present?
    @tournaments = policy_scope(@tournaments.where("end_date <= (?)", params[:end_date])) if params[:end_date].present?

  end
end
