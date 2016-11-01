class RemoveNullConstraintFromUserPasswordField < ActiveRecord::Migration[5.0]
  def change
    # Because password digest will be saved instead apparently
    change_column_null :users, :password, true
  end
end
