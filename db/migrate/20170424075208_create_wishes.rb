class CreateWishes < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|
      t.references :user, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
