class AddAddressToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :address_1, :string
    add_column :locations, :address_2, :string
    add_column :locations, :city, :string
    add_column :locations, :region, :string
    add_column :locations, :country, :string
    add_column :locations, :longitude, :float
    add_column :locations, :latitude, :float
  end
end
