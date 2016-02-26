module Analyzable
  def self.average_price(item_array)
    sum = 0.0
    item_array.each do |item|
      sum += item.price.to_f
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

  def self.print_report(item_array)
    avg_price = average_price(item_array)
    brands = count_by_brand(item_array)
    names = count_by_name(item_array)
    report = "Average Price: #{avg_price}\n"
    report += "Inventory by Brand:\n"
    report += create_lines(brands)
    report += "Inventory by Name:\n"
    report += create_lines(names)
  end

  def create_lines(summary_hash)
    report = ""
    summary_hash.each do |k, v|
      report += "\t- #{k}: #{v}\n"
    end
    report
  end
end
