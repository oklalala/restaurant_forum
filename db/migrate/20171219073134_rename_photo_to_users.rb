class RenamePhotoToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :avarar, :avatar
  end
end
