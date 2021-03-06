class CreateCandidatureDenials < ActiveRecord::Migration[6.1]
  def change
    create_table :candidature_denials do |t|
      t.references :candidature, null: false, foreign_key: true
      t.text :feedback

      t.timestamps
    end
  end
end
