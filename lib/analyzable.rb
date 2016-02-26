module Analyzable
  def self.average_price(item_array)
    sum = 0.0
    item_array.each do |item|
      sum += item.price
    end
    (sum / item_array.size).round(2) if item_array.size > 0
  end

  def self.count_by_brand(item_array)
    brands = {}
    item_array.each do |item|
      brands[item.brand] = 0 unless brands[item.brand]
      brands[item.brand] += 1
    end
    brands
  end

  def self.count_by_name(item_array)
    names = {}
    item_array.each do |item|
      names[item.name] = 0 unless names[item.name]
      names[item.name] += 1
    end
    names
  end
end
