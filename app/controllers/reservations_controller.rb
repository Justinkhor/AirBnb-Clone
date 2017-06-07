class ReservationsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]


	def index
		@reservations = current_user.reservations
	end

	def show

	end

  def edit

  end

  def create
    @listing = Listing.find(params[:listing_id])
		@reservation = current_user.reservations.new(reservation_params)
    @reservation.listing = @listing
    if @reservation.save
      @host = User.find(@listing.user_id)
          # ReservationMailer.reservation_email(current_user, @host, @reservation.listing.id, @reservation.id).deliver_later
          ReservationJob.perform_later(current_user, @host, @reservation.listing.id, @reservation.id)
  		redirect_to new_reservation_braintree_path(@reservation) , notice: "Your reservation has been created, please make payment to confirm the reservation."
    else
      @errors = @reservation.errors.full_messages
      render "listings/show"
    end
	end

  def update
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to @reservation.user
  end

  private
		def reservation_params
			params.require(:reservation).permit(:check_in, :check_out, :num_of_guests, :listing_id, :user_id)
		end

end
