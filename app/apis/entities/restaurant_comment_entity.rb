module Restfuls
	module APIEntities
		class RestaurantComment < Grape::Entity
          expose :id, as: :cid
      	  expose :author, as: :author
      	  expose :title, as: :title
          expose :comment, as: :comment
          expose :point, as: :point
          expose :created_at, as: :created_at, format_with: :iso_timestamp
          format_with(:iso_timestamp) { |date| date.iso8601 }
    end
	end
end