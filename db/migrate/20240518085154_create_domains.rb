class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.integer :user_id
      t.string :name
      t.string :model_type
      t.string :model_identifier
      t.integer :model_result

      t.timestamps
    end
  end
end
