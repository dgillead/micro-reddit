class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.date :join_date, null: false
      t.timestamps
    end
  end
end
