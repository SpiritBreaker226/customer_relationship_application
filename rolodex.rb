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
end