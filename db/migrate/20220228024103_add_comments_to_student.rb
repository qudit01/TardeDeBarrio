# frozen_string_literal: true

class AddCommentsToStudent < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :student_id, :integer
    add_reference :comments, :student, null: false, foreign_key: true
  end
end
