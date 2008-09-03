class CreateSpacestations < ActiveRecord::Migration
  def self.up
    create_table :spacestations do |t|
	 	t.string :name, :image
		t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :spacestations
  end
end
