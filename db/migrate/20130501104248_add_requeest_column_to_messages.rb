class AddRequeestColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :request, :string, default: nil
  end
end
