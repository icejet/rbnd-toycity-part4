module Analyzable
  def self.average_price(item_array)
    sum = 0.0
    item_array.each do |item|
      sum += item.price
    end
    (sum / item_array.size).round(2) if item_array.size > 0
  end
end
