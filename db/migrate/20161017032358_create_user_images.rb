class CreateUserImages < ActiveRecord::Migration[5.0]
  def change
    UserImage.create_index!
  end
end
