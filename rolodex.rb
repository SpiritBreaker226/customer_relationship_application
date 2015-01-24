require_relative "./contact.rb"

class Rolodex
	@@index = 1001

	def initialize
		@contacts = []
		add_contact(Contact.new("Jason", "Stats", "j@s.com", "Note"))
		add_contact(Contact.new("Bob", "Stathopulos", "w@sat.com", ""))
		add_contact(Contact.new("Billy", "Bob", "w@sat.com", "1234"))
	end
	
	def add_contact(contact)
		contact.id = @@index 
		@contacts << contact
		@@index += 1
	end

	def modify_contact(contact_id, modify_attribute, modify_value)
		found_contact = search_contact(contact_id)

		unless found_contact == nil
			case modify_attribute
			when 1 then found_contact.first_name = modify_value
			when 2 then found_contact.last_name = modify_value
			when 3 then found_contact.email = modify_value
			when 4 then found_contact.note = modify_value				
			end
		end
	end

	def delete_contact(contact_id)
		@contacts.delete_if { |contact| contact.id.to_i == contact_id.to_i }
	end

	def display_all_contacts
		@contacts.join("\n")
	end

	def display_particular_contact(contact_id)
		found_contact = search_contact(contact_id)

		found_contact.empty? ? "Contact Not Found" : found_contact
	end

	def search_contact(contact_id)
		@contacts.find_all { |contact| contact.id.to_i == contact_id.to_i }
	end
end