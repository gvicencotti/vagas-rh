class CompaniesController < ActionController::Base
  def new
    @company = Company.new
  end

  def create
    company_params = params.require(:company).permit(:company_name, :city, :address,
      :district, :cnpj, :site)
    @company = Company.new(company_params)

    if @company.save
      user = User.find(current_user.id)
      user.company_id = @company.id
      user.save
      redirect_to @company
    else
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:id])
  end

end
