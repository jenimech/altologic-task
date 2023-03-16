require_relative 'Item'

class App

  attr_accessor :new_item, :items

  def initialize
    @new_item = true
    @items = []
  end

  def welcome_messages
    puts "This is a small app to test inputs and outputs, lets started!"
  end

  def bye_message
    puts "Bye bye!"
  end

  def start
    welcome_messages
    puts 'Do you want to enter an new Item? Y/n'
    new_item = gets.chomp == 'Y' ? true : false
    while new_item
      items << get_item
      puts 'Do you want to enter an new Item? Y/n'
      new_item = gets.chomp == 'Y' ? true : false
    end
    if items.empty?
      bye_message 
    else
      output_items
    end
  end

  def get_item
    puts ">> Please, Enter the description of the item"
    description = gets.chomp
    str = ''
    Item::TYPES.each {|x| str = str + "#{x[0]}-#{x[1]}\n"}
    puts ">> Please, Enter the type of the item, choose the correct number:\n #{str}"
    type = gets.chomp
    puts ">> Please, Enter the price of the item:"
    amount = gets.chomp
    puts ">> Please, Enter the cuantity of the item:"
    count = gets.chomp
    item = Item.new(count, description, type, amount)
  end

  def output_items
    taxes = 0
    total = 0
    puts "** OUTPUT **"
    items.each do |item|
      total_by_item = (item.count.to_i * item.amount.to_f) + item.total_tax
      puts "#{item.count} #{item.description}: #{total_by_item.round(2)}"
      taxes += item.total_tax
      total += total_by_item
    end
    puts "Sales Taxes: #{taxes.round(2)}"
    puts "Total: #{(total).round(2)}"
  end
end