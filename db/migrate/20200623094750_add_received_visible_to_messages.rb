class AddReceivedVisibleToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :received_visible, :boolean, default: true
  end
end
