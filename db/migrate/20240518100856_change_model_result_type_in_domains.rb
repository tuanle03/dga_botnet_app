class ChangeModelResultTypeInDomains < ActiveRecord::Migration[7.0]
  def up
    change_column :domains, :model_result, :string
  end

  def down
    change_column :domains, :model_result, :integer
  end
end
