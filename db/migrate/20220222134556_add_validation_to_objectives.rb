# frozen_string_literal: true

class AddValidationToObjectives < ActiveRecord::Migration[7.0]
  def change
    change_column_null :objectives, :user_id, false
    change_column_null :objectives, :student_id, false
  end
end
