class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end

  def search
    @vacancies = Vacancy.joins(:company).where('company_name like ? OR role like ?',
      "%#{params[:q]}%", "%#{params[:q]}%")
  end

end