# frozen_string_literal: true

class CreateObjectives < ActiveRecord::Migration[7.0]
  def change
    create_table :objectives do |t|
      t.string :content, null: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
