class CandidatureDenial < ApplicationRecord
  belongs_to :candidature

  validates :feedback, presence: true
end
