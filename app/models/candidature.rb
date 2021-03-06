class Candidature < ApplicationRecord
  belongs_to :vacancy
  belongs_to :user

  enum status: { pendent: 0, valued: 5 }

  Candidature.joins(:vacancy)
  Candidature.joins(:user)
end
