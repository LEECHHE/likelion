class Student < ActiveRecord::Base
	def self.multi a, b
		c = a * b
		return c
	end

	def minus a, b
		a - b
	end

	def get_enter_year
		return self.number.split("-").first
	end
end
