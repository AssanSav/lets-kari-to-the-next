class AddSentVisibleToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :sent_visible, :boolean, default: true
  end
end
