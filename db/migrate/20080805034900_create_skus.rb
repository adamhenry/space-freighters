class CreateSkus < ActiveRecord::Migration
  def self.up
    create_table :skus do |t|
	 	t.string :name, :image, :type
		t.decimal :size, :percision => 24, :scale => 3
		t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :skus
  end
end
