class AddGameIdToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :game_id, :integer
  end
end
