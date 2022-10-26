# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :content, null: false
      t.integer :likes, null: false, default: 0
      t.integer :user_id, null: false
      t.integer :student_id, null: false

      t.timestamps
    end
  end
end
