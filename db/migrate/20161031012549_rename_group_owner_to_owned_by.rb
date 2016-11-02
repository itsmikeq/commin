class RenameGroupOwnerToOwnedBy < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :owner, :owned_by
  end
end
