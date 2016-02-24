require_relative 'lib/product'
require_relative 'data/seeds'

def test
  path = File.dirname(__FILE__) + "/data/data.csv"
  CSV.open(path, "wb") do |csv|
    csv << ["id", "brand", "product", "price"]
  end

  5.times do
    Product.create(brand: "WalterToys", name: "Sticky Notes", price: 34.00)
  end

  Product.create(brand: "ColtToys", name: "Orchid Plant", price: 2.00)

  product = Product.first
  data = CSV.read(path).drop(1)
  puts data.first[0].to_i == product.id
  File.delete(path)
end

100.times do
  test
end
