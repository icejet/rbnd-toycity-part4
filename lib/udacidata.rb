require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  PATH = File.dirname(__FILE__) + "/../data/data.csv"
  Module.create_finder_methods(:brand, :name)

  def self.create(options = {})
    new_product = Product.new(options)
    in_db = object_in_db?(new_product)
    insert_data(to_csv_array(new_product)) unless in_db
    new_product
  end

  def self.all
    data = CSV.read(PATH).drop(1)
    products = []
    data.each do |line|
      products << array_to_objects(line)
    end
    products
  end

  def self.first(n = 0)
    return all.first if n == 0
    all.first(n)
  end

  def self.last(n = 0)
    return all.last if n == 0
    all.last(n)
  end

  def self.find(id)
    found = all.find do |record|
      record.id == id
    end
    check_product_exists(found)
    found
  end

  def self.destroy(id)
    deleted = Product.find(id)
    check_product_exists(deleted)
    overwrite_file(generate_post_delete_array(deleted))
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
    new_brand = options[:brand] ? options[:brand] : brand
    new_name = options[:name] ? options[:name] : name
    new_price = options[:price] ? options[:price] : price
    Udacidata.destroy(id)
    Udacidata.create(id: id, brand: new_brand, name: new_name, price: new_price)
  end

  def self.generate_post_delete_array(product)
    database = CSV.read(PATH)
    new_database = database.select do |record|
      record[0].to_i != product.id
    end
    new_database
  end

  def self.overwrite_file(csv_array)
    CSV.open(PATH, "wb") do |csv|
      csv_array.each do |record|
        csv << record
      end
    end
  end

  def self.insert_data(data_array)
    CSV.open(PATH, "ab") do |csv|
      csv << data_array
    end
  end

  def self.to_csv_array(data_object)
    [data_object.id, data_object.brand, data_object.name, data_object.price]
  end

  def self.array_to_objects(csv_array)
    create(id: csv_array[0], brand: csv_array[1], name: csv_array[2], price: csv_array[3])
  end

  def self.object_in_db?(db_object)
    db = CSV.read(PATH)
    existing_record = db.find do |record|
      record[0].to_i == db_object.id
    end
    existing_record
  end

  def self.check_product_exists(found)
    raise ProductNotFoundError unless found
  end


end
