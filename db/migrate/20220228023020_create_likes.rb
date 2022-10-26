# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.boolean :given, default: true
      t.references :likeable, polymorphic: true
      t.references :user, index: true, foreign_key: {to_table: :users}
      t.integer :student_id

      t.timestamps
    end
  end
end
