class CandidatureApprovalsController < ApplicationController
  def new
    @candidature_approval = CandidatureApproval.new
    @candidature_id = params[:candidature_id]
  end

  def create
    candidature_approval_params = params.require(:candidature_approval).permit(:candidature_id, :salarial_proposal, :start_date)
    @candidature_approval = CandidatureApproval.new(candidature_approval_params)

    @candidature_id = @candidature_approval.candidature_id

    if @candidature_approval.save
      candidature = Candidature.find(@candidature_id)
      candidature.update(status: 5)
      flash[:notice] = 'Proposta enviada com sucesso.'
      render 'new'
    else
      render 'new'
    end      
  end

  def show
    @candidature_approval = CandidatureApproval.where('candidature_id = ?', params[:id])
  end
  
  def accept
    @candidature_approval = CandidatureApproval.find(params[:id])
    candidature_id = @candidature_approval.candidature_id
    @candidature_approval.accepted!
    redirect_to candidature_approval_path(candidature_id)
  end

  def reject
    @candidature_approval = CandidatureApproval.find(params[:id])
    candidature_id = @candidature_approval.candidature_id
    @candidature_approval.rejected!
    redirect_to candidature_approval_path(candidature_id)
  end

end