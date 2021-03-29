class HomeController < ApplicationController
  def index
    @user = User.find(current_user.id) if user_signed_in?
  end

  def search
    @vacancies = Vacancy.joins(:company).where('company_name like ? OR role like ?',
                                               "%#{params[:q]}%", "%#{params[:q]}%")
  end
end
