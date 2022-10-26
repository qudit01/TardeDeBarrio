# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.boolean :highlight, null: false
      t.string :img_src
      t.integer :user_id, null: false
      t.integer :student_id, null: false

      t.timestamps
    end
  end
end
