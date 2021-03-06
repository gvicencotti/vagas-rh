class CreateCandidatureApprovals < ActiveRecord::Migration[6.1]
  def change
    create_table :candidature_approvals do |t|
      t.references :candidature, null: false, foreign_key: true
      t.string :salarial_proposal
      t.date :start_date

      t.timestamps
    end
  end
end
