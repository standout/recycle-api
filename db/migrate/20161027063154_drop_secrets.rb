class DropSecrets < ActiveRecord::Migration[5.0]
  def change
    drop_table :secrets
  end
end
