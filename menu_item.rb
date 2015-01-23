class MenuItem
	attr_accessor :name
	attr_reader :number

	def initialize(name, number)
		@name = name
		@number = number
	end
	
	def to_s
		"#{@number}. #{@name}"
	end
end