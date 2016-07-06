class AddPictureToLocationImage < ActiveRecord::Migration
  def self.up
	  change_table :location_images do |t|
	    t.attachment :picture
	  end
	end

	def self.down
	  remove_attachment :location_images, :picture
	end

end
