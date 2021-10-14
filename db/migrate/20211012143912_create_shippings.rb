class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.text :phone
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
