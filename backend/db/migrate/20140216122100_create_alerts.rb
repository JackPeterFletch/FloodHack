class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.float :latitude
			t.float :longitude
		 	t.string :alertType, :null => false, :default => ""
		  t.text :desc, :null => false, :default => ""
			t.integer :user_id

      t.timestamps
    end
  end
end
