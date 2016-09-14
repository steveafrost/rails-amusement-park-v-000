class Ride < ActiveRecord::Base
	belongs_to :user
	belongs_to :attraction

	def take_ride
		if low_tickets? && too_short?
			"Sorry. You do not have enough tickets the #{current_attraction.name}. You are not tall enough to ride the #{current_attraction.name}."
		elsif low_tickets?
			"Sorry. You do not have enough tickets the #{current_attraction.name}."
		elsif too_short?
			"Sorry. You are not tall enough to ride the #{current_attraction.name}."
		else
			update_tickets
			update_nausea
			update_happiness
			current_user.save
		end
	end

	private

	def current_user
		self.user
	end

	def current_attraction
		self.attraction
	end

	def low_tickets?
		current_user.tickets <= current_attraction.tickets
	end

	def too_short?
		current_user.height <= current_attraction.min_height
	end

	def update_tickets
		current_user.tickets -= current_attraction.tickets
	end

	def update_nausea
		current_user.nausea += current_attraction.nausea_rating
	end

	def update_happiness
		current_user.happiness += current_attraction.happiness_rating
	end
end
