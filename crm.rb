require_relative "./rolodex.rb"
require_relative "./contact.rb"
require_relative "./menu.rb"

class CRM
	attr_reader :name

	def initialize(name)
		@name = name
		@rolodex = Rolodex.new
		@menu = Menu.new("Add", "Modify", "Display All", "Display Contact", "Display Attribute", "Delete", "Exit")
	end

	def main_menu
		puts "Welcome to #{@name}"

		while true
			print_main_menu
			input = gets.chomp.to_i
			choose_option(input)
			return if input == 7
		end
	end

	def choose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contact
		when 4 then display_contact
		when 5 then display_attribute
		when 6 then delete_contact
		when 7 
			puts "Goodbye!"
			return
		end
	end

	private

	def add_contact
		puts "Provide Contact Details"

		print "First Name: "
		first_name = gets.chomp

		print "Last Name: "
		last_name = gets.chomp

		print "Email: "
		email = gets.chomp

		print "Note: "
		note = gets.chomp

		@rolodex.add_contact(Contact.new(first_name, last_name, email, note))
	end

	def print_main_menu
		puts  @menu 
		print "Enter a number: "
	end
end

bitmaker = CRM.new("Bitmaker Labs CRM")
bitmaker.main_menu