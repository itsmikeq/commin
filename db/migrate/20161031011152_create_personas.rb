class CreatePersonas < ActiveRecord::Migration[5.0]
  def change
    create_table :personas do |t|
      t.references :user, foreign_key: true
      t.string :screen_name
      t.references :group, foreign_key: true
      t.boolean :default

      t.timestamps
    end
  end
end
