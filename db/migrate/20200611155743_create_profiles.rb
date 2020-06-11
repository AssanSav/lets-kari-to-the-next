class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :city
      t.string :age
      t.string :sex
      t.string :orientation
      t.string :ethnicity
      t.string :height
      t.string :body_shape
      t.string :children
      t.string :reletionship
      t.string :education
      t.string :image
      t.text :bio
      t.integer :user_id

      t.timestamps
    end
  end
end
