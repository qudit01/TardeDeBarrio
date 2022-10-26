class RemoveAnswerIdFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :answer_id, :integer
  end
end
