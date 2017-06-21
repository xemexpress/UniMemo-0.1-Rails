class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |t|
      t.text :text
      t.string :image
      t.string :gift_id
      t.datetime :expire_at
      t.references :provider, foreign_key: true
      t.references :receiver, foreign_key: true

      t.timestamps
    end
  end
end
