class CreateBunches < ActiveRecord::Migration[5.2]
  def change
    create_table :bunches do |t|
      t.float :cost, null: false
      t.integer :quantity, null: false, default: 1
      t.string :ripeness, null: false
      t.integer :seller_id, null: false

      t.timestamps
    end

    add_index :bunches, :seller_id
  end
end
