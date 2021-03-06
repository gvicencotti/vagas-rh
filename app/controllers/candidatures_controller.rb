class CandidaturesController < ActionController::Base

  def create
    @candidature = Candidature.new
    @candidature.vacancy_id = params[:vacancy_id]
    @candidature.user_id = current_user.id
    
    if @candidature.save
      flash[:notice] = 'Candidatura registrada com sucesso!'
      redirect_to vacancy_path(params[:vacancy_id])
    end
  end

  def show
    @vacancy_id = params[:id]
    @candidature = Candidature.where(' vacancy_id = ?', @vacancy_id )
  end

end
  
