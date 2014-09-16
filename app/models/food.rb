class Food < ActiveRecord::Base
	belongs_to :food_type

	def is_promote?
		return self.is_promote != 0 && self.promote_end_date && Time.new > self.promote_end_date ? true :false
	end
end