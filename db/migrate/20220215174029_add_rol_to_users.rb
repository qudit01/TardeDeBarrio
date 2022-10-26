# frozen_string_literal: true

class AddRolToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rol, :integer, default: 1
  end
end
