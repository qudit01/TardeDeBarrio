# frozen_string_literal: true

class AddUserToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :user, null: false, foreign_key: true
  end
end
