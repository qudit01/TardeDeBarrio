# frozen_string_literal: true

class RemoveUserFromObjectives < ActiveRecord::Migration[7.0]
  def change
    remove_column :objectives, :user, :integer
  end
end
