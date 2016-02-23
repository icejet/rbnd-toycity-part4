require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@data = []
  @@path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(options = {})
    new_product = Product.new(options)
    @@data << new_product
    insert_data(to_csv_array(new_product))
    new_product
  end

  def self.all
    @@data
  end

  def self.first
    @@data.first
  end

  def self.insert_data(data_array)
    CSV.open(@@path, "ab") do |csv|
      csv << data_array
    end
  end

  def self.to_csv_array(database_obj)
    [database_obj.id, database_obj.brand, database_obj.name, database_obj.price]
  end
end
