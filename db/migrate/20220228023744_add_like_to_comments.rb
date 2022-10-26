# frozen_string_literal: true

class AddLikeToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :comment, index: true, null: false, foreign_key: true
  end
end
