class CreateDistances < ActiveRecord::Migration
  def self.up
    create_table :distances do |t|
	 	t.integer :sp1, :sp2
		t.decimal :distance, :percision => 11, :scale => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :distances
  end
end
