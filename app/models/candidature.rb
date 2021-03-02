class Candidature < ApplicationRecord

  enum status: { Pendente: 0, Recusado: 5, Aceito: 10 }
end
