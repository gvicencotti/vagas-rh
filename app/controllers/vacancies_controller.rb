class VacanciesController < ApplicationController
  
  def index
    @vacancies = Vacancy.visitor_valid_vacancies

    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end

  def show
    @visible = true
    @vacancy = Vacancy.find(params[:id])
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.company_id == @vacancy.company_id
        @visible = false
      end
    end
  end

  def new
    @vacancy = Vacancy.new
    user = User.find(current_user.id)

    if user.cpf.nil?
      redirect_to edit_user_registration_path(current_user.id)
      flash[:notice] = 'Necessário preencher o perfil e 
                        cadastrar empresa antes de criar nova vaga.'
    end
  end

  def create
    vacancy_params = params.require(:vacancy).permit(:role, :description,
                                    :requirements, :localization, :expiration_date)
    @vacancy = Vacancy.new(vacancy_params)
    
    user = User.find(current_user.id)
    @vacancy.company_id = user.company_id

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
      
    vacancy_params = params.require(:vacancy).permit(:role, :description, 
      :requirements, :localization, :expiration_date)

    if @vacancy.update(vacancy_params)
      redirect_to @vacancy
    else
      render :edit
    end
  end
  
  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy

    redirect_to @vacancy, :notice => 'Vaga deletada com sucesso!'
  end
end
