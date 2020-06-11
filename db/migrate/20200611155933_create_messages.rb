class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_id
      t.integer :match_id
      t.boolean :status

      t.timestamps
    end
  end
end
