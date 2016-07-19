class RenameDateAvailableToAvailableDate < ActiveRecord::Migration
  def change
  	rename_table :date_availables, :available_dates
  end
end
