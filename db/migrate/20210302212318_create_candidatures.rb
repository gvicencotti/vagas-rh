class CreateCandidatures < ActiveRecord::Migration[6.1]
  def change
    create_table :candidatures do |t|
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
