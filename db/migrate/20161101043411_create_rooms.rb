class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    Room.create_index!
  end
  def down
    `curl -XDELETE 'http://localhost:9201/_all'`
  end
end
