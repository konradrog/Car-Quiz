class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true
      t.references :car, foreign_key: true
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
