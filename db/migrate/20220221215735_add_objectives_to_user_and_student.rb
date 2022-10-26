# frozen_string_literal: true

class AddObjectivesToUserAndStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :objectives, :user_id, :integer
    add_column :objectives, :student_id, :integer
  end
end
