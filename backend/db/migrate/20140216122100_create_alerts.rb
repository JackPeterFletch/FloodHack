class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.decimal :lat, {:precision => 10, :scale => 6}
			t.decimal :lng, {:precision => 10, :scale => 6}
    	t.string :postcode, :null => false, :default => ""
		 	t.string :alertType
		  t.text :desc
			t.integer :user_id

      t.timestamps
    end
  end
end
