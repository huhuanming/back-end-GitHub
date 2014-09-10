require 'spec_helper'

describe FoodType do
	before(:each) do
      @promotioner = FactoryGirl.create(:promotioner)
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      restaurant_id = @restaurant.id

      @food_type = FactoryGirl.create(:food_type, restaurant_id: restaurant_id, type_name:"翔翔")
      @parent_food_type = FactoryGirl.create(:food_type, restaurant_id: restaurant_id)
      5.times { |n|  @son_food_type = FactoryGirl.create(:food_type, parent_id: @parent_food_type.id, restaurant_id: restaurant_id, type_name: ("菜"<<n))}
	end
	it 'Has_parent: no parent' do
        expect(@food_type.has_parent?).to eq(false)
	end

	it 'Has_parent: parent' do
        expect(@son_food_type.has_parent?).to eq(true)
	end

	it 'Son_food_types: no son' do
        expect(@food_type.son_food_types).to eq(nil)
	end

	it 'parent_food_type: no parent' do
        expect(@son_food_type.parent_food_type).to eq(@parent_food_type)
	end

	it 'parent_food_type: parent' do
        expect(@food_type.parent_food_type).to eq(nil)
	end
end