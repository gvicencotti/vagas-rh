class VacanciesController < ApplicationController
  
  def index
    @vacancies = Vacancy.visitor_valid_vacancies
  end

  def show
    @vacancy = Vacancy.find(params[:id])
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    vacancy_params = params.require(:vacancy).permit(:company, :role, :description,
                                    :requirements, :localization, :expiration_date)
    @vacancy = Vacancy.new(vacancy_params)
   
    if @vacancy.save
      redirect_to @vacancy
    else
      render 'new'
    end
  end
  
  def edit
    @vacancy = Vacancy.find(params[:id])
  end

  def update
    @vacancy = Vacancy.find(params[:id])
    
    vacancy_params = params.require(:vacancy).permit(:company, :role, :description,
    :requirements, :localization, :expiration_date)

    if @vacancy.update(vacancy_params)
      redirect_to @vacancy
    else
      render :edit
    end
    
  end
       
end
