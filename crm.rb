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

	def ask_for_contact_id
		puts "Enter an id of a contact?"
		gets.chomp
	end

	def choose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contacts
		when 4 then display_particular_contact
		when 5 then display_attribute
		when 6 then delete_contact
		when 7 
			puts "Goodbye!"
			return
		else
			puts "Number not found"
		end
	end

	def confirm_id?(contact_id)
		while true
			print "Is this the correct id #{contact_id} ('yes' or 'no'): "
			user_confirm_id = gets.chomp.downcase

			return true if user_confirm_id == "yes"
			return false if user_confirm_id == "no"
		end
	end

	def delete_contact
		contact_id = ask_for_contact_id

		@rolodex.delete_contact(contact_id) if confirm_id?(contact_id)
	end

	def display_all_contacts
		puts "All contacts in the rolodex\n\n#{@rolodex.display_all_contacts}"
	end

	def display_particular_contact
		puts @rolodex.display_particular_contact(ask_for_contact_id)
	end

	def modify_contact
		contact_id = ask_for_contact_id

		if confirm_id?(contact_id)
			puts "Provide Attribute"

			puts Menu.new("First Name", "Last Name", "Email", "Note")
			print "Enter a number: "
			modify_attribute = gets.chomp

			print "Change #{modify_attribute} to: "
			modify_value = gets.chomp

			@rolodex.modify_contact(contact_id, modify_attribute, modify_value)
		end
	end

	def print_main_menu
		puts  @menu 
		print "Enter a number: "
	end
end

bitmaker = CRM.new("Bitmaker Labs CRM")
bitmaker.main_menu