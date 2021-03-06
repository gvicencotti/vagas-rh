class Candidature < ApplicationRecord
  belongs_to :vacancy
  belongs_to :user

  enum candidature_status: { pendente: 1, recusado: 2, aceito: 3 }

  Candidature.joins(:vacancy)
  Candidature.joins(:user)
end
