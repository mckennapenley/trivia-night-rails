# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :points
      t.text :prompt
      t.text :answer
      t.integer :order

      t.timestamps
    end
  end
end
