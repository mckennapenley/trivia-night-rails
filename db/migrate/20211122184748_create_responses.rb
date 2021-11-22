class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.boolean :answered_correctly
      t.integer :team_id
      t.integer :question_id

      t.timestamps
    end
  end
end
