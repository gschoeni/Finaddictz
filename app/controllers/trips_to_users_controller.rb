class TripsToUsersController < ApplicationController
	def accept_user_on_trip
		trip_to_user = TripsToUser.find(params[:id])
    guide_post = GuidePost.find(params[:guide_post_id])
    user = User.find(params[:user_id])
    trip_to_user.accepted = true

    Notification.create(
      user_id: trip_to_user.user_who_agreed_id,
      notification_type: NotificationType.find_by_name("trip_confirmed").id,
      title: "Your trip request has been acceepted.",
      message: "Your trip with #{guide_post.user} has been accepted, click the link below to view the trip details.",
      related_id: guide_post.id
    )

    if guide_post.isFull?
    	guide_post.booking_status_id = BookingStatus.find_by_status("Booked")
    	guide_post.save!
    end

    if trip_to_user.save!
    	redirect_to edit_guide_post_path(guide_post), notice: "#{user} has been accepted on your trip."
		else 
			redirect_to edit_guide_post_path(guide_post), notice: "There was an error accepting the user, please report to Finaddictz so we can fix it asap."
		end
  end
end