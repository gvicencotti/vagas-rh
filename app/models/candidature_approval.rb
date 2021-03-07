class CandidatureApproval < ApplicationRecord
  belongs_to :candidature

  validates :salarial_proposal, :start_date, presence: true

  enum offer_response:  { pendent: 0, accepted: 5, rejected: 10}
end
