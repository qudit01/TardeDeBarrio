class RemoveLikesFromAnswers < ActiveRecord::Migration[7.0]
  def change
    remove_column :answers, :likes, :integer
  end
end
