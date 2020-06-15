class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :image
      t.integer :age
      t.string :city
      t.string :gender
      t.string :orientation
      t.string :ethnicity
      t.string :height
      t.string :body_shape
      t.string :children
      t.string :relationship
      t.string :education
      t.text :bio
      t.string :password_digest

      t.timestamps
    end
  end
end
