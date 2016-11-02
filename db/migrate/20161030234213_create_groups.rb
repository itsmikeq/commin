class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :permission
      t.string :owner
      t.string :type

      t.timestamps
    end
  end
end
