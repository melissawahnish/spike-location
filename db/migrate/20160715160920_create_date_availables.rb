class CreateDateAvailables < ActiveRecord::Migration
  def change
    create_table :date_availables do |t|
      t.belongs_to :location
      t.date :available_date
      t.belongs_to :reservation
      t.boolean :reserved, default: false

      t.timestamps null: false
    end
  end
end
