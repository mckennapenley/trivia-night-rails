class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :question_quantity

      t.timestamps
    end
  end
end
