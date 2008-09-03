class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
	 	t.references :sku, :spacestation
		t.decimal :price, :percision => 24, :decimal => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
