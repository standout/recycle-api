class ChangeNameToEmail < ActiveRecord::Migration[5.0]
  def change
    rename_column :admins, :name, :email
  end
end
