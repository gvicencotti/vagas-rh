class CandidatureDenialsController < ApplicationController
  def new
    @candidature_denial = CandidatureDenial.new
    @candidature_id = params[:candidature_id]
  end

  def create
    candidature_denial_params = params.require(:candidature_denial).permit(:candidature_id, :feedback)
    @candidature_denial = CandidatureDenial.new(candidature_denial_params)

    @candidature_id = @candidature_denial.candidature_id

    if @candidature_denial.save
      candidature = Candidature.find(@candidature_id)
      candidature.update(status: 10)
      flash[:notice] = 'Feedback enviado com sucesso.'
      render 'new'
    else
      render 'new'
    end      
  end

  def show
    @candidature_denial = CandidatureDenial.where('candidature_id = ?', params[:id])
  end
end
