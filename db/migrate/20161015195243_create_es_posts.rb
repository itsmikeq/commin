class CreateEsPosts < ActiveRecord::Migration[5.0]
  def change
    Post.__elasticsearch__.create_index!
  end
end
