class AddColumnToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :finished, :boolean, default: false
  end
end
