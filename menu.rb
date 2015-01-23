require "./menu_item.rb"

class Menu
	attr_accessor :menu_items

	def initialize(*menu_items)
		@menu_items = []
		menu_items.each { |menu_item| @menu_items << MenuItem.new(menu_item, (@menu_items.count + 1)) }
	end
	
	def to_s
		menu_items.join("\n")
	end
end