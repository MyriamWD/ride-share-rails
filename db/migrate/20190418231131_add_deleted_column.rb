class AddDeletedColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :deleted, :boolean
  end
end
