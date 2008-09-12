class CreateShips < ActiveRecord::Migration
  def self.up
    create_table :ships do |t|
    t.string :name
    t.integer :location_id
    t.decimal :fuel, :persition => 38, :scale => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :ships
  end
end
