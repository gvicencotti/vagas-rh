class AddOfferResponseToCandidatureApproval < ActiveRecord::Migration[6.1]
  def change
    add_column :candidature_approvals, :offer_response, :integer, default: 0
  end
end
