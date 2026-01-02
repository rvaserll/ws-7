class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.integer :number
      t.string :message
      t.datetime :client_time

      t.timestamps
    end
  end
end
