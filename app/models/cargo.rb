class Cargo < ActiveRecord::Base
  belongs_to :ship
  belongs_to :sku

  def amount
    amount_text.to_i
  end
  
  def amount=(amount)
    self.amount_text = amount.to_s
  end
  
  # a cargos name is that of its sku
  def name
    sku.name
  end

  #size returns the enter size of the cargo. If size of an indiviual sku is neede sku.size is suficent
  def size
    sku.size * amount
  end

end
