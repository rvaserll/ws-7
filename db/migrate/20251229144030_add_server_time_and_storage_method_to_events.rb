class AddServerTimeAndStorageMethodToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :server_time, :datetime
    add_column :events, :storage_method, :string
  end
end
