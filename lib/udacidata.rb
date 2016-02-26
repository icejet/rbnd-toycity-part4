require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@data = []
  @@path = File.dirname(__FILE__) + "/../data/data.csv"
  Module.create_finder_methods(:brand, :name)

  def self.create(options = {})
    new_product = Product.new(options)
    @@data << new_product
    insert_data(to_csv_array(new_product)) # unless object_in_db?(new_product.id)
    new_product
  end

  def self.all
    @@data
  end

  def self.first(n = 0)
    return @@data.first if n == 0
    @@data[0..n - 1]
  end

  def self.last(n = 0)
    return @@data.last if n == 0
    n *= -1
    @@data[n..-1]
  end

  def self.find(id)
    @@data.find do |record|
      record.id == id
    end
  end

  def self.destroy(id)
    # Seriously refactor this mess.
    deleted = Product.find(id)
    database = CSV.read(@@path)

    new_database = database.select do |record|
      record[0].to_i != id
    end

    CSV.open(@@path, "wb") do |csv|
      new_database.each do |record|
        csv << record
      end
    end
    deleted
  end

  def self.where(options)
    if options[:name]
      all.select do |product|
        product.name == options[:name]
      end
    elsif options[:brand]
      all.select do |product|
        product.brand == options[:brand]
      end
    end
  end

  def update(options)
    brand = options[:brand] ? options[:brand] : brand
    name = options[:name] ? options[:name] : name
    price = options[:price] ? options[:price] : price
    Udacidata.destroy(id)
    Udacidata.create(id: id, brand: brand, name: name, price: price)
  end

  def self.insert_data(data_array)
    CSV.open(@@path, "ab") do |csv|
      csv << data_array
    end
  end

  def self.to_csv_array(data_object)
    [data_object.id, data_object.brand, data_object.name, data_object.price]
  end

  def self.object_in_db?(obj_id)
    # TODO check other fields not id.
    db = CSV.read(@@path)
    db.find do |record|
      obj_id == record[0].to_i
    end
  end
end
