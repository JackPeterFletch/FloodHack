class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.float :latitude
			t.float :longitude
    	t.string :postcode, :null => false, :default => ""
		 	t.string :alertType
		  t.text :desc
			t.integer :user_id

      t.timestamps
    end
  end
end
