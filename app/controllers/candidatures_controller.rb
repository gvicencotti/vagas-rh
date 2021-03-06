class CandidaturesController < ActionController::Base

  def create
    @candidature = Candidature.new
    @candidature.vacancy_id = params[:vacancy_id]
    @candidature.user_id = current_user.id
    user = User.find(current_user.id)

    if user.cpf.nil?
      flash[:notice] = 'Necessário preencher perfil para se cadastrar a vagas.'
      redirect_to vacancy_path(params[:vacancy_id])
    else
      @candidature.save
      flash[:notice] = 'Candidatura registrada com sucesso!'
      redirect_to vacancy_path(params[:vacancy_id])
    end
  end

  def show
    @vacancy_id = params[:id]
    @candidature = Candidature.where(' vacancy_id = ?', @vacancy_id ) 
  end

  def users_show
    @candidature = Candidature.where(' user_id = ?', params[:user_id] )
  end

end
  
