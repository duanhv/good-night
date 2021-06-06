class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :sender, references: :users, null: false
      t.references :receiver, references: :users, null: false

      t.timestamps
    end
  end
end
