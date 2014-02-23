class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.float :lat
			t.float :lon
			t.string :address, :null => false, :default => ""
		 	t.string :alertType, :null => false, :default => ""
		  t.text :desc, :null => false, :default => ""
			t.integer :user_id

      t.timestamps
    end

    add_index :alerts, :id
    add_index :alerts, :user_id

  end
end
