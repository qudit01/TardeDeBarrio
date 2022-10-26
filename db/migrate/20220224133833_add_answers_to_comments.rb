# frozen_string_literal: true

class AddAnswersToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :comment, null: false, foreign_key: true
  end
end
