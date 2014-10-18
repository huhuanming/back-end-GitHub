require 'spec_helper'

describe Food do
	before(:each) do
      @promotioner = FactoryGirl.create(:promotioner)
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      restaurant_id = @restaurant.id
      
      @food_type = FactoryGirl.create(:food_type, restaurant_id: restaurant_id, type_name:"翔翔")
      @food = FactoryGirl.create(:food, food_type_id: @food_type.id)
	end
	it 'Is_promote: no promote' do
        expect(@food.is_promote?).to eq(false)

		@food.is_promote = 1
		@food.save
        expect(@food.is_promote?).to eq(false)


		@food.is_promote = 1
		@food.promote_end_date = Time.new + 1.year
		@food.save
        expect(@food.is_promote?).to eq(false)
	end

	it 'Is_promote: promote' do
		@food.is_promote = 1
		@food.promote_end_date = Time.new - 1.year
		@food.save
        expect(@food.is_promote?).to eq(true)
	end
end