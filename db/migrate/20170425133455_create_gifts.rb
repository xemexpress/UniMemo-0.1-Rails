class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |t|
      t.text :text
      t.string :image
      t.string :gift_id
      t.datetime :expire_at
      t.integer :provider_id
      t.integer :receiver_id

      t.timestamps
    end
    add_foreign_key :gifts, :users, column: :provider_id
    add_foreign_key :gifts, :users, column: :receiver_id
  end
end
