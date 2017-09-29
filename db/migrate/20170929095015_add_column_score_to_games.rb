class AddColumnScoreToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :score, :integer, default: 100
  end
end
