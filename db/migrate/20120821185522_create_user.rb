class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :surname
      t.boolean :admin, default: false
      t.boolean :enabled, defaul: true
    end
  end
end
