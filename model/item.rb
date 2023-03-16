class Item
  attr_accessor :count, :description, :type, :amount, :basic_tax, :export_tax, :total_tax
  
  BASIC_TAX_EXCENT = ['book', 'food', 'medical-products']
  BASIC_TAX_PERCENT = 10
  EXPORT_TAX_PERCENT = 5
  TYPES = { '1' => 'book', '2' => 'food', '3' => 'medical-products', '4' => 'other' }

  def initialize(count, description, type, amount)
    @count = count
    @description = description
    @type = type
    @amount = amount || 0
    @basic_tax = calculate_basic_tax || 0
    @export_tax = calculate_export_tax || 0
    @total_tax = calculate_total_tax || 0
  end

  def calculate_basic_tax
    return 0 if type.nil?
    unless BASIC_TAX_EXCENT.include?(TYPES[type.to_s])
      amount.to_f * BASIC_TAX_PERCENT / 100
    end
  end

  def calculate_export_tax
    return 0 if description.nil?
    if description.include?('imported')
      amount.to_f * EXPORT_TAX_PERCENT / 100
    end
  end

  def calculate_total_tax
    ( basic_tax + export_tax ) * count.to_i
  end 
end
