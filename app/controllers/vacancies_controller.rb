class VacanciesController < ApplicationController
  
  def index
    @vacancies = Vacancy.visitor_valid_vacancies
  end

  def show
    @vacancy = Vacancy.find(params[:id])
  end


end
