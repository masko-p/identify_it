class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :identifier, null: false, uniqueness: true

      t.timestamps
    end
  end
end
