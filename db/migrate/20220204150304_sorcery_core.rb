# frozen_string_literal: true

class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :crypted_password, null: false
      t.string :salt
    end
  end
end
