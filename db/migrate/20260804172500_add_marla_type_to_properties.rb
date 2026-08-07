class AddMarlaTypeToProperties < ActiveRecord::Migration[8.1]
  def change
    add_column :properties, :marla_type, :integer
  end
end
