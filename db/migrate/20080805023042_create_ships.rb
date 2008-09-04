class CreateShips < ActiveRecord::Migration
  def self.up
    create_table :ships do |t|
		t.string :name
	 	t.integer :location_id, :fuel

      t.timestamps
    end
  end

  def self.down
    drop_table :ships
  end
end
