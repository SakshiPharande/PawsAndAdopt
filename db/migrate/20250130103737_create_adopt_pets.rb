class CreateAdoptPets < ActiveRecord::Migration[7.2]
  def change
    create_table :pet_adopt_requests do |t|
      t.string :email, null: false
      t.string :address, null: false
      t.string :phone_no, null: false
      t.datetime :adoption_date
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.references :breed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
