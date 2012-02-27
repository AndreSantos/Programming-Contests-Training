class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.references :problem
      t.references :contest

      t.timestamps
    end
  end
end
