require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  @@data = []

  def self.create(options = {})
    csv_array = setup_row(options)
    CSV.open(@@data_path, "ab") do |csv|
      csv << csv_array
    end
    @@data << Product.new(options)
    @@data.last
  end

  def self.setup_row(options)
    csv_array = []
    options.map do |_k, v|
      csv_array << v
    end
    csv_array
  end

  def self.all
    @@data
  end
end
