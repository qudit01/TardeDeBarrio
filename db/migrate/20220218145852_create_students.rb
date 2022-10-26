# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.date :birthday, null: false
      t.string :address, null: false
      t.integer :scholarity, default: 0
      t.boolean :goes_to_school, null: false

      t.timestamps
    end
  end
end
