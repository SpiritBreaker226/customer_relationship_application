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
		clear_screen
		puts "Welcome to #{@name}"

		while true
			print_main_menu
			input = gets.chomp.to_i
			choose_option(input)
			pause_and_clear_screen
		end
	end

	private

	def add_contact
		puts "Provide Contact Details"

		first_name 	=	ask_user_for_input("First Name: ")
		last_name 	=	ask_user_for_input("Last Name: ")
		email 			=	ask_user_for_input("Email: ")
		note 				=	ask_user_for_input("Note: ")

		@rolodex.add_contact(Contact.new(first_name, last_name, email, note))
	end

	def ask_for_contact_id
		ask_user_for_input("Enter an id of a contact?")
	end

	def ask_user_for_input(question)
		puts question
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
			exit
		else
			puts "Number not found"
		end
	end

	def clear_screen
		puts "\e[H\e[2J"
	end

	def confirm_id?(contact_id)
		while true
			print "Is this the correct id #{contact_id} ('yes' or 'no'): "
			user_confirm_id = gets.chomp.downcase

			return true if user_confirm_id == "yes"
			return false if user_confirm_id == "no"
		end
	end

	def display_contact_info(contact_info, what_was_not_found = "contact")
		puts contact_info == nil ? "Unable to find #{what_was_not_found}" : contact_info
	end

	def delete_contact
		contact_id = ask_for_contact_id

		if confirm_id?(contact_id)
			puts "Deleted Summery"
			display_contact_info(@rolodex.delete_contact(contact_id))
		end
	end

	def display_all_contacts
		puts "All contacts in the rolodex\n\n#{@rolodex.display_all_contacts}"
	end

	def display_attribute
		print "Enter a either ('firstname', 'lastname', 'email', or 'notes')\nto display all contacts with that attribute: "

		display_contact_info(@rolodex.display_info_by_attribute(gets.chomp), "attribate")
	end

	def display_particular_contact
		display_contact_info(@rolodex.display_particular_contact(ask_for_contact_id))
	end

	def modify_contact
		contact_id = ask_for_contact_id

		if confirm_id?(contact_id)
			puts "Provide Attribute"

			puts Menu.new("First Name", "Last Name", "Email", "Note")

			modify_attribute = ask_user_for_input("Enter a number: ")
			modify_value = ask_user_for_input("Change #{modify_attribute} to: ")

			puts "Update Summery"
			display_contact_info(@rolodex.modify_contact(contact_id, modify_attribute, modify_value))
		end
	end

	def pause_and_clear_screen
		ask_user_for_input("Press a key to continue")
		clear_screen
	end

	def print_main_menu
		puts  @menu 
		print "Enter a number: "
	end
end

bitmaker = CRM.new("Bitmaker Labs CRM")
bitmaker.main_menu