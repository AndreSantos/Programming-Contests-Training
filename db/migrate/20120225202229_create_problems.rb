class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :name
      t.integer :total_inputs
      t.references :contest

      t.timestamps
    end
  end
end
