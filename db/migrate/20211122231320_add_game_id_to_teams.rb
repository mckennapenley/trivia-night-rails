# frozen_string_literal: true

class AddGameIdToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :game_id, :integer
  end
end
