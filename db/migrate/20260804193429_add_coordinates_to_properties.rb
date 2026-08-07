class AddCoordinatesToProperties < ActiveRecord::Migration[8.1]
  def change
    add_column :properties, :latitude, :float
    add_column :properties, :longitude, :float
  end
end
