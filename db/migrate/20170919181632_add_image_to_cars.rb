class AddImageToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :image, :oid
  end
end
