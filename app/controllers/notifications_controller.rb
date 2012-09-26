class NotificationsController < ApplicationController
	def index
		@notifications = Notification.find_all_by_user_id(current_user.id, :order => "created_at desc")
		notifications = current_user.notifications
		notifications.each do |n|
			n.read = true
			n.save()
		end
	end
end

