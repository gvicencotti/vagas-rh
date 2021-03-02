class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: { Candidate: 0, Admin: 5 }

  validates :complete_name, :cpf, :phone_number, :biography, presence: true, on: :update
  #belongs_to :company
   
  def company
    User.joins(:company)
  end

end
