class RemoveLikesFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :comment, index: true, null: false, foreign_key: true
  end
end
