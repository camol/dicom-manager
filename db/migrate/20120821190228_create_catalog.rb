class CreateCatalog < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :name
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :catalogs, :user_id
  end
end
