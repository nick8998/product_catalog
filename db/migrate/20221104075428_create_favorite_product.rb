class CreateFavoriteProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_products do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
