class Candidature < ApplicationRecord
  belongs_to :vacancy

  enum candidature_status: { pendente: 1, recusado: 2, aceito: 3 }
end
