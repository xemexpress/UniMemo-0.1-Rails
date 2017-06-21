class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.datetime :start_time
      t.string :start_place
      t.datetime :end_time
      t.string :end_place
      t.text :text
      t.string :image
      t.string :request_id
      t.integer :wishes_count
      t.integer :poster_id
      t.integer :helper_id

      t.timestamps
    end
    add_foreign_key :requests, :users, column: :poster_id
    add_foreign_key :requests, :users, column: :helper_id
    add_index :requests, :request_id, unique: true
  end
end
