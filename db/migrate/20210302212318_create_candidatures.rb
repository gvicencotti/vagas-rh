class CreateCandidatures < ActiveRecord::Migration[6.1]
  def change
    create_table :candidatures do |t|
      t.string :vacancy_id, null: false
      t.string :user_id, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
