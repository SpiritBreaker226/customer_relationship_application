class Rolodex
	@@index = 1001

	def initialize
		@contacts = []
	end
	
	def add_contact(contact)
		contact.id = @@index 
		@contacts << contact
		@@index += 1
	end

	def modify_contact(contact_id, modify_attribute, modify_value)
		found_contact = @contacts.find { |contact| contact.id == contact_id }

		unless found_contact == nil
			case modify_attribute
			when 1 then found_contact.first_name = modify_value
			when 2 then found_contact.last_name = modify_value
			when 3 then found_contact.email = modify_value
			when 4 then found_contact.note = modify_value				
			end
		end
	end
end