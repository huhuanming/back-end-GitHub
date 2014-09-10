class FoodType < ActiveRecord::Base
	has_many :foods
	belongs_to :restaurant

	def has_parent?
		return self.parent_id != 0
	end

	def parent_food_type
		return self.has_parent? ? FoodType.find_by(:id => parent_id):nil
	end

	def son_food_types
		food_type = FoodType.where(:parent_id => self.id)
		return food_type.count == 0 ? nil : food_type
	end
end