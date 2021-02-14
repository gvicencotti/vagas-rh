class HomeController < ApplicationController
  
  def index
  end

  def search
    @vacancies = Vacancy.where('company like ? OR role like ?',
      "%#{params[:q]}%", "%#{params[:q]}%")
  end

end