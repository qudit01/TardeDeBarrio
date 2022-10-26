# frozen_string_literal: true

class RemoveStudentFromObjectives < ActiveRecord::Migration[7.0]
  def change
    remove_column :objectives, :student, :integer
  end
end
