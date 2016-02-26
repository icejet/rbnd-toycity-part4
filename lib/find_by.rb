class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
      new_method = %Q{
        def find_by_#{attribute}(input_value)
          self.all.find { |product| product.#{attribute} == input_value }
        end
      }
      class_eval(new_method)
    end
  end
end
