class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.string :body_style
      t.string :segment

      
      t.timestamps
    end
  end
end
