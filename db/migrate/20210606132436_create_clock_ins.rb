class CreateClockIns < ActiveRecord::Migration[6.1]
  def change
    create_table :clock_ins do |t|
      t.references :user, null: false
      t.datetime :sleep_at
      t.datetime :wake_up_at
      t.integer :sleep_time_in_second

      t.timestamps
    end
  end
end
