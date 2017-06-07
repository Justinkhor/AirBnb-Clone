class ReservationMailer < ApplicationMailer
  default from: 'justinairbnbclone@gmail.com'
  def reservation_email(customer, host, listing_id, reservation_id)
      @host = host
      @customer = customer
      @listing = Listing.find(listing_id)
      @reservation_id = reservation_id
      #once customer reserved a listing, it will send email to the listing host.
      mail(to: @host.email, subject: "You have received a booking from #{@customer}")
  end
end
