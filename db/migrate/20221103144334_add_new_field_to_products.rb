class AddNewFieldToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :details, :string
    add_column :products, :hand, :boolean
  end
end
