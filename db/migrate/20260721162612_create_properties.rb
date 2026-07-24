class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.text :location
      t.string :city
      t.decimal :price
      t.integer :area
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :property_type
      t.integer :purpose
      t.integer :status

      t.timestamps
    end
  end
end
