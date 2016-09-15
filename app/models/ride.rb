class Ride < ActiveRecord::Base
	belongs_to :user
	belongs_to :attraction

	def take_ride
		if low_tickets? && too_short?
			"You do not have enough tickets to ride the #{current_attraction.name}. You are not tall enough to ride the #{current_attraction.name}."
		elsif low_tickets?
			"You do not have enough tickets to ride the #{current_attraction.name}."
		elsif too_short?
			"You are not tall enough to ride the #{current_attraction.name}."
		else
			update_tickets
			update_nausea
			update_happiness
			current_rider.save
			"Thanks for riding the #{current_attraction.name}!"
		end
	end

	private

	def current_rider
		self.user
	end

	def current_attraction
		self.attraction
	end

	def low_tickets?
		current_rider.tickets <= current_attraction.tickets
	end

	def too_short?
		current_rider.height <= current_attraction.min_height
	end

	def update_tickets
		current_rider.tickets -= current_attraction.tickets
	end

	def update_nausea
		current_rider.nausea += current_attraction.nausea_rating
	end

	def update_happiness
		current_rider.happiness += current_attraction.happiness_rating
	end
end
