class AddUserIdToIdeas < ActiveRecord::Migration[7.0]
  def change
    add_column :ideas, :user_id, :integer
    add_index :ideas, :user_id
  end
end
