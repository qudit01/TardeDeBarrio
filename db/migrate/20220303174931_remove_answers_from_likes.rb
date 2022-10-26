class RemoveAnswersFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :answer, :integer
  end
end
