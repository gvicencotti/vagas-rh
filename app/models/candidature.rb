class Candidature < ApplicationRecord
  belongs_to :vacancy
  belongs_to :user

  enum status: { pendent: 0, approved: 5, denied: 10 }

  Candidature.joins(:vacancy)
  Candidature.joins(:user)
end
