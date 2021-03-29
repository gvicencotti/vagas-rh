class CompaniesController < ApplicationController
  def new
    user = User.find(current_user.id)
    if user.cpf.nil?
      redirect_to edit_user_registration_path(current_user.id)
      flash[:notice] = 'Necessário preencher o perfil
                        antes de cadastrar nova empresa.'
    elsif user.company_id.nil?
      @company = Company.new
    else
      redirect_to company_path(user.company_id)
    end
  end

  def create
    company_params = params.require(:company).permit(:company_name, :city, :address,
                                                     :district, :cnpj, :site)
    @company = Company.new(company_params)

    if @company.save
      user = User.find(current_user.id)
      user.update(company_id: @company.id)
      redirect_to @company
    else
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:id])
  end
end
