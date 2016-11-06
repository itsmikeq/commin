class AddVisibilityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :visibility, :integer
  end
end
