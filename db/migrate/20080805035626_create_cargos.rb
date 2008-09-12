class CreateCargos < ActiveRecord::Migration
  def self.up
    create_table :cargos do |t|
    t.references :ship, :sku
    t.text :amount_text
      t.timestamps
    end
  end

  def self.down
    drop_table :cargos
  end
end
