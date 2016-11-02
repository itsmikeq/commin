class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :photo_url
      t.text :intro
      t.string :sex
      t.string :religion
      t.string :political_party
      t.string :language
      t.string :nickname
      t.integer :visibility

      t.timestamps
    end
  end
end
